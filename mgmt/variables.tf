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
variable "management_account_name" {
  description = "The name of the management account"
  type        = string
  default     = ""
} 
variable "management_account_email" {
  description = "The email address of the management account"
  type        = string
  default     = ""
}
variable "management_account_id" {
  description = "The account ID of the management account"
  type        = string
  default     = ""
}
# Role name for management account to assume in other accounts
variable "rolename_for_mgmt_account" {
  description = "Role name for management account to assume"
  type        = string
  default     = "OrganizationAccountAccessRole"
}


###########################################
# Delegated Admin Account Variables
###########################################
# Delegated Admin Account Variables
variable "delegated_admin_account_email" {
  description = "The email address for the delegated admin account"
  type        = string
  default   = ""
}

variable "delegated_account_name" {
  description = "The name for the delegated admin account"
  type        = string
  default     = ""
}



###########################################
# Security Logging Account Variables
###########################################
# Security Logging Account Variables
variable "security_logging_account_email" {
  description = "The email address for the security logging account"
  type        = string
  default   = ""
}

variable "security_logging_account_name" {
  description = "The name for the security logging account"
  type        = string
  default     = ""
}
###########################################



###########################################
# Infrastructure Account Variables
###########################################
# Infrastructure Account Variables
variable "infrastructure_account_email" {
  description = "The email address for the infrastructure account"
  type        = string
  default   = ""
}

variable "infrastructure_account_name" {
  description = "The name for the infrastructure account"
  type        = string
  default     = ""
}
###########################################



# User 1 Admin 1 email
variable "user1_admin1_email" {
  description = "Email address for User 1 Admin 1"
  type        = string
  default     = ""
}