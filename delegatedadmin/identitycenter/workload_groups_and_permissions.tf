data "aws_ssoadmin_instances" "myidstore" {}

# identity store id and ARN
locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.myidstore.identity_store_ids)[0]
  identity_store_arn = tolist(data.aws_ssoadmin_instances.myidstore.arns)[0]
}


# Create an IAM Identity Center group for Administrators of AWS accounts in general
resource "aws_identitystore_group" "workload_administrators_group" {
  identity_store_id = local.identity_store_id
  display_name      = "Workload Administrators"
  description       = "Workload Administrator group"
}

# Create an IAM Identity Center group for Developers
resource "aws_identitystore_group" "developers_group" {
  identity_store_id = local.identity_store_id
  display_name      = "Developers"
  description       = "Developers group"
}

########### Permission sets for WorkloadAdministrators #############
resource "aws_ssoadmin_permission_set" "workload_administrator" {
  name             = "WorkloadAdministrator"
  description      = "Provides administrator access to AWS resources"
  instance_arn     = local.identity_store_arn
  session_duration = "PT1H" # 1 hours session duration (ISO-8601 standard)
}

# Attach the AdministratorAccess managed policy to the permission set created above
resource "aws_ssoadmin_managed_policy_attachment" "workloadadmin_policy_attach" {
  instance_arn       = local.identity_store_arn
  permission_set_arn = aws_ssoadmin_permission_set.workload_administrator.arn
  # The ARN for the built-in AdministratorAccess policy

  # checkov:skip=CKV_AWS_274:The AdministratorAccess policy is required for admin access
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


########### Permission sets for Developers #############
resource "aws_ssoadmin_permission_set" "developer" {
  name             = "Developer"
  description      = "Provides developer access to AWS resources"
  instance_arn     = local.identity_store_arn
  session_duration = "PT1H" # 1 hours session duration (ISO-8601 standard)
}

# Attach the PowerUser managed policy to the permission set created above
resource "aws_ssoadmin_managed_policy_attachment" "developer_policy_attach" {
  instance_arn       = local.identity_store_arn
  permission_set_arn = aws_ssoadmin_permission_set.developer.arn
  # The ARN for the built-in PowerUser policy
  managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}


# Add the user to the Workload Administrators group
resource "aws_identitystore_group_membership" "workload_administrators_group_membership" {
  identity_store_id = var.identity_store_id
  group_id          = aws_identitystore_group.workload_administrators_group.group_id
  member_id         = var.user_id
}

# Add the user to the Developer group
resource "aws_identitystore_group_membership" "developer_group_membership" {
  identity_store_id = var.identity_store_id
  group_id          = aws_identitystore_group.developers_group.group_id
  member_id         = var.user_id
}