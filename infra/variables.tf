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
# Stackset variables
###########################################
variable "trusted_account_id" {
  description = "The trusted account ID. This should be the infra account id"
  type        = string
  default  = ""
}

variable "trusted_role_arn" {
  description = "The trusted role ARN"
  type        = string
  default  = ""
}

variable "organization_root_id" {
  description = "The organization root ID"
  type        = string
  default  = ""
}