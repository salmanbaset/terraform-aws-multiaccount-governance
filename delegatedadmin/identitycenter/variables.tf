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