# AWS profile to use
profile = "securitylogging-admin"  # ADD YOUR SECURITY LOGGING ACCOUNT ADMIN USER PROFILE
region = "us-east-2"

cloudtrail_bucket_prefix = "cloudtrail-bucket"  # ADD YOUR CLOUDTRAIL S3 BUCKET PREFIX, e.g., cloudtrail-bucket
force_destroy_cloudtrail_bucket = false  # Set to true to allow bucket deletion during testing
cloudtrail_prefix = "cloudtrail-management-logs"  # ADD YOUR CLOUDTRAIL LOGS PREFIX IN THE S3 BUCKET