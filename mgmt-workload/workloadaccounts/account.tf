resource "aws_organizations_account" "aws_account" {
  name  = var.account_name
  email = var.account_email # Must be a unique email address not associated with any other AWS account

  # Specify the Organizational Unit ID of WorkloadOU
  parent_id = var.workload_ou_id
  
  # Role name created in the new account that the management account can assume
  role_name = var.rolename_for_mgmt_account
  
  # This is a workload account so we want to automatically close upon deletion
  close_on_deletion = true
}

output "aws_account_id" {
  value = aws_organizations_account.aws_account.id
}