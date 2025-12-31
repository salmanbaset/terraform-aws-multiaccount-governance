###########################################
# Workload Account Variables
###########################################
# Account Variables
variable "account_email" {
  description = "The email address for the account"
  type        = string
  default   = ""
}

variable "account_name" {
  description = "The name for the account"
  type        = string
  default     = ""
}
###########################################

# Role name for management account to assume in other accounts
variable "rolename_for_mgmt_account" {
  description = "Role name for management account to assume"
  type        = string
  default     = "OrganizationAccountAccessRole"
}


# Workload OU ID
variable "workload_ou_id" {
  description = "The Organizational Unit ID for Workload OU"
  type        = string
  default     = ""
}
