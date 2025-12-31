# Configure the AWS Provider
# Ensure your credentials have the necessary permissions in the target AWS account
provider "aws" {
  profile = var.profile
  region = var.region # AWS Organizations region
  skip_requesting_account_id = true # Trail is technically created in management account, but we are using delegated admin to create the trail. So there is an account identity mismatch
}

module "cloudtrail" {
  source = "./cloudtrail"

  profile = var.profile
  region  = var.region
  cloudtrail_bucket_prefix = var.cloudtrail_bucket_prefix
  force_destroy_cloudtrail_bucket = var.force_destroy_cloudtrail_bucket
  cloudtrail_prefix = var.cloudtrail_prefix
}