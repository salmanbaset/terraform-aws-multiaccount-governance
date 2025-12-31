variable "profile" {
  description = "The AWS profile to use"
  type        = string
  default   = ""
}

variable "region" {
  description = "The AWS region to use"
  type        = string
  default   = ""
}

###########################################
# CloudTrail Variables
###########################################
variable "cloudtrail_bucket_prefix" {
  description = "The CloudTrail S3 bucket prefix"
  type        = string
  default   = ""
}

variable "force_destroy_cloudtrail_bucket" {
  description = "Whether to force destroy the CloudTrail bucket"
  type        = bool
  default   = true
}

variable "cloudtrail_prefix" {
  description = "The CloudTrail name prefix in the S3 bucket"
  type        = string
  default     = "cloudtrail-management-logs"
}