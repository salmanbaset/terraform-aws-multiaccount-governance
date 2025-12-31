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
# Management Account Import Prep
###########################################
variable "management_account_id" {
  description = "The account ID of the management account"
  type        = string
  default     = ""
}

variable "organization_root_id" {
  description = "The root ID of your AWS organization"
  type        = string
  default     = ""
}

###########################################
# Identity Centre Variables
###########################################
variable "identity_store_id" {
  description = "The identity store instance ID"
  type        = string
  default     = ""
}

variable "user_id" {
  description = "The user ID for the identity center user assigned to the delegated admin account"
  type        = string
  default     = ""
}
