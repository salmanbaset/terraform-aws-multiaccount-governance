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

####################################################
# Permission set, group, and AWS account variables
####################################################
variable "permission_set_arn" {
  description = "The ARN of the permission set to assign"
  type        = string
  default   = ""
}

variable "group_id" {
  description = "The ID of the Identity Center group"
  type        = string
  default   = ""
}

variable "account_id" {
  description = "The ID of the AWS account to assign the permission set and group to"
  type        = string
  default   = ""
}