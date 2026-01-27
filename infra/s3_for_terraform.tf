# Retrieve information about the current account dynamically. This must be the
# Infra account since the S3 bucket is created there.
data "aws_caller_identity" "current" {}

# 1. Create S3 bucket to store Terraform state file for this account
resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "terraform-bucket-${data.aws_caller_identity.current.account_id}" # Ensure globally unique bucket name

  # force_destroy = false is recommended for production to prevent accidental data loss. Set to true for testing purposes.
  force_destroy = true 

  tags = {
    Name        = "Terraform State Bucket for Infra Account"
    Environment = "Governance"
  }
}

# 2. Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_bucket.id
  versioning_configuration {
    # mfa_delete = "Enabled"  # Uncomment and configure MFA delete for extra security in production
    status = "Enabled"
  }
}

# 3. Set lifecycle rule to manage old versions and expired objects
resource "aws_s3_bucket_lifecycle_configuration" "terraform_bucket_lifecycle" {
  bucket = aws_s3_bucket.terraform_bucket.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    # This targets noncurrent versions specifically. 
    # Keep it to small values to avoid costs which are negligible anyway but can add up
    # since we will likely forget about this bucket initial setup.
    noncurrent_version_expiration {
      noncurrent_days           = 2
      newer_noncurrent_versions = 2
    }

    # remove incomplete multipart uploads after 1 day. There should not be any
    # multipart uploads for Terraform state files, but just in case as a
    # safety measure.
    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

# 4. Enforce bucket ownership to the bucket owner
resource "aws_s3_bucket_ownership_controls" "terraform_bucket_ownership" {
  bucket = aws_s3_bucket.terraform_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# 5. Block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "terraform_bucket_pab" {
  bucket = aws_s3_bucket.terraform_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 6. All AWS buckets are encrypted by default, but still having
# this in code is a good practice
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Use AWS managed S3 keys (SSE-S3)
    }
  }
}


# 7. Define the policy document using Terraform's IAM policy data source
data "aws_iam_policy_document" "restrict_to_account" {
  statement {
    sid    = "AllowLocalAccountOnly"
    effect = "Allow"

    # Restricts access to principals within the local account only
    # The ":root" suffix here represents the account itself, not the root user.
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.terraform_bucket.arn,
      "${aws_s3_bucket.terraform_bucket.arn}/*"
    ]
  }
}

# 8. Create the Bucket Policy that restricts access to this account only
resource "aws_s3_bucket_policy" "local_account_access" {
  bucket = aws_s3_bucket.terraform_bucket.id
  policy = data.aws_iam_policy_document.restrict_to_account.json
}