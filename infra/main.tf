# Configure the AWS Provider
# Ensure your credentials have the necessary permissions in the target AWS account
provider "aws" {
  profile = var.profile
  region = var.region # AWS Organizations region
}

data "aws_caller_identity" "this" {}
data "aws_organizations_organization" "this" {}

module "infrastacksets" {
  source = "./stacksets"

  trusted_account_id = data.aws_caller_identity.this.id  ## Account ID of infra account
  trusted_role_arn   = var.trusted_role_arn
  organization_root_id = data.aws_organizations_organization.this.roots[0].id  # Role ARN of Administrators in Infra so that Prowler can assume role from desktop
  region = var.region
}
