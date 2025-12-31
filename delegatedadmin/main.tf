provider "aws" {
  profile = var.profile
  region = var.region # AWS Organizations region
}

module "scp" {
  source = "./scp"
  management_account_id = var.management_account_id
  organization_root_id       = var.organization_root_id
}

module "identitycenter" {
  source = "./identitycenter"

  identity_store_id = var.identity_store_id
  user_id           = var.user_id
}