# Configure the AWS Provider
# Ensure your credentials have the necessary permissions in the target AWS account
provider "aws" {
  profile = var.profile
  region = var.region # AWS Organizations region
  skip_requesting_account_id = true # Trail is technically created in management account, but we are using delegated admin to create the trail. So there is an account identity mismatch
}

###########################################################################################
# Create Dev Workload Account and assign Developer/Administrator group and permission set
###########################################################################################
module "workloadaccounts" {
  source = "./workloadaccounts"
  workload_ou_id = var.workload_ou_id
  account_email = var.dev_account_email
  account_name = var.dev_account_name
}

module "identitycenter_developer_group_permissions_developer_account" {
  source = "./identitycenter"

  identity_center_arn = var.identity_center_arn
  account_id = module.workloadaccounts.aws_account_id
  permission_set_arn = var.developer_permission_set_arn
  group_id = var.developers_group_id
}

module "identitycenter_workload_administrator_group_permissions_developer_account" {
  source = "./identitycenter"

  identity_center_arn = var.identity_center_arn
  account_id = module.workloadaccounts.aws_account_id
  permission_set_arn = var.workload_administrator_permission_set_arn
  group_id = var.workload_administrators_group_id
}

###########################################################################################
# Create Production Workload Account and assign Developer/Administrator group and permission set
###########################################################################################
module "workloadaccount_production" {
  source = "./workloadaccounts"
  workload_ou_id = var.workload_ou_id
  account_email = var.production_account_email
  account_name = var.production_account_name
}

module "identitycenter_developer_group_permissions_production_account" {
  source = "./identitycenter"

  identity_center_arn = var.identity_center_arn
  account_id = module.workloadaccount_production.aws_account_id
  permission_set_arn = var.developer_permission_set_arn
  group_id = var.developers_group_id
}

module "identitycenter_workload_administrator_group_permissions_production_account" {
  source = "./identitycenter"

  identity_center_arn = var.identity_center_arn
  account_id = module.workloadaccount_production.aws_account_id
  permission_set_arn = var.workload_administrator_permission_set_arn
  group_id = var.workload_administrators_group_id
}