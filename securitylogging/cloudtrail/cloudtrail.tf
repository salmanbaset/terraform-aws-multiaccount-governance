# 0. Data source for the current AWS account ID. This should be the Security Logging account.
data "aws_caller_identity" "current" {}


#####################################################
# CloudTrail S3 Bucket for Security Logging Account
#####################################################

# 1. Create a dedicated S3 bucket for CloudTrail logs with versioning and encryption enabled
resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "${var.cloudtrail_bucket_prefix}-${data.aws_caller_identity.current.account_id}" # Use a unique bucket name

  # force_destroy = false is recommended for production to prevent accidental data loss. Set to true for testing purposes.
  force_destroy = var.force_destroy_cloudtrail_bucket 

  tags = {
    Name        = "Cloud Trail bucket for Security Logging Account"
    Environment = "SecurityLogging"
  }
}


# 2. Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "cloudtrail_bucket_versioning" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  versioning_configuration {
    # mfa_delete = "Enabled"  # Uncomment and configure MFA delete for extra security in production
    status = "Enabled"
  }
}

# 3. Set lifecycle rule to manage old versions and expired objects
# It is set to 1 non-current day and 1 non-concurrent version for cost reasons; adjust as needed for production
resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail_bucket_lifecycle" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    # This targets noncurrent versions specifically. 
    # Keep it to small values to avoid costs.
    noncurrent_version_expiration {
      noncurrent_days           = 1
      newer_noncurrent_versions = 1
    }
  }
}

# 4. Enforce bucket ownership to the bucket owner
resource "aws_s3_bucket_ownership_controls" "cloudtrail_bucket_ownership" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# 5. Block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "cloudtrail_bucket_pab" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 6. All AWS buckets are encrypted by default, but still having
# this in code is a good practice
resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_bucket_encryption" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Use AWS managed S3 keys (SSE-S3)
    }
  }
}


# 7. Secure bucket policy: only CloudTrail can write logs, and only authorized users can read them
data "aws_iam_policy_document" "cloudtrail_bucket_policy" {
  # A. policy statements to allow CloudTrail to write logs to the bucket
  statement {
    effect = "Allow"
    # AWS documentation requires specific principals for the CloudTrail service to write to the bucket
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail_bucket.arn}/${var.cloudtrail_prefix}/*"]
  }

  # B. policy statement to allow CloudTrail to get the bucket ACL
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail_bucket.arn]
  }

  # C. policy statement to allow only the Security Logging account to read the logs
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"] 
    }
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [aws_s3_bucket.cloudtrail_bucket.arn, 
      "${aws_s3_bucket.cloudtrail_bucket.arn}/*",
      "${aws_s3_bucket.cloudtrail_bucket.arn}/${var.cloudtrail_prefix}/*"
    ]
  }
}

# 8. Apply policy to the CloudTrail S3 bucket
resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy_attachment" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = data.aws_iam_policy_document.cloudtrail_bucket_policy.json
}

#####################################################
# Create the CloudTrail
#####################################################
resource "aws_cloudtrail" "security_logging_cloudtrail" {
  name                          = "cloudtrail-management-events-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  include_global_service_events = true  # Include global service events
  is_multi_region_trail         = true  # CloudTrail across all regions
  is_organization_trail         = true  # CloudTrail for the entire organization

  enable_log_file_validation    = true  # Enable log file integrity validation
  s3_key_prefix                 = "${var.cloudtrail_prefix}"  # Optional prefix for log files in the bucket
  enable_logging                = true

  # Optional: Configure CloudWatch Logs for real-time monitoring and alerting
  # Uncomment the following lines and add necessary IAM role resources if needed
  # cloud_watch_logs_group_arn  = aws_cloudwatch_log_group.cloudtrail_logs.arn
  # cloud_watch_logs_role_arn   = aws_iam_role.cloudtrail_cloudwatch_role.arn
}