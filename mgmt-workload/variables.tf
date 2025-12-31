###########################################
# Provider Variables
###########################################
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


#################################################################
# Management Account, Identity Center, and Workload OU variables
#################################################################
# Management Account ID
variable "management_account_id" {
  description = "The ID of the management account"
  type        = string
  default   = ""
}

# Identity Center ARN
variable identity_center_arn {
  description = "The ARN of the Identity Center instance"
  type        = string
  default     = ""
}

# Workload OU ID
variable "workload_ou_id" {
  description = "The ID of the workload organizational unit"
  type        = string
  default   = ""
}

###########################################
# Workload Account Variables
###########################################
# Dev Account Variables
variable "dev_account_email" {
  description = "The email address for the dev account"
  type        = string
  default   = ""
}

variable "dev_account_name" {
  description = "The name for the dev account"
  type        = string
  default     = ""
}

# Production Account Variables
variable "production_account_email" {
  description = "The email address for the production account"
  type        = string
  default   = ""
}

variable "production_account_name" {
  description = "The name for the production account"
  type        = string
  default     = ""
}
###########################################


############################################
# Group an Permission Set Variables
############################################
variable "security_analysts_group_id" {
  description = "The group ID for the security analysts group"
  type        = string
  default     = ""
}
variable "security_analyst_permission_set_arn" {
  description = "The permission set ARN for the security analysts"
  type        = string
  default     = ""
}
variable "developers_group_id" {
  description = "The group ID for the developers group"
  type        = string
  default     = ""
}
variable "developer_permission_set_arn" {
  description = "The permission set ARN for the developers"
  type        = string
  default     = ""
}
variable "workload_administrators_group_id" {
  description = "The group ID for the workload administrators group"
  type        = string
  default     = ""
}
variable "workload_administrator_permission_set_arn" {
  description = "The permission set ARN for the workload administrators"
  type        = string
  default     = ""
}
############################################