# Assign the permission set to the Security Analysts Group in Infrastructure Account
resource "aws_ssoadmin_account_assignment" "account_group_permissions_assignment" {
  # The ARN of the SSO instance
  instance_arn = var.identity_center_arn

  # The ARN of the permission set
  permission_set_arn = var.permission_set_arn
  
  # The ID of the principal (group)
  principal_id = var.group_id

  # The type of principal (must be GROUP)
  principal_type = "GROUP"

  # The ID of the target AWS account
  target_id = var.account_id

  # The type of target (must be AWS_ACCOUNT)
  target_type = "AWS_ACCOUNT"
}