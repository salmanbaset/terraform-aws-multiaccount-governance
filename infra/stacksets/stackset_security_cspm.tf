resource "aws_cloudformation_stack_set" "security-audit-cspm-stackset" {
  name             = "cf-stackset-security-audit-cspm-role"
  description      = "Deploy this stack set to all OUs for cloud security posture management tool"
  permission_model = "SERVICE_MANAGED"
  call_as          = "DELEGATED_ADMIN"

  auto_deployment {
    enabled = true
  }

  capabilities = [
    "CAPABILITY_NAMED_IAM",
  ]

  template_body = file("${path.root}/stacksets/cft/cross_account_iam_role_security_audit.yaml")
  parameters = {
    RoleName          = "security-cspm"
    RoleDescription   = "Audit findings"
    #PolicyName        = "security-cspm-sechub-import"
    #PolicyDescription = "Allow import SecurityHub findings"
    IAMPath           = "/security/cspm/"
    TrustedAccount    = var.trusted_account_id
    TrustedRole       = var.trusted_role_arn
  }
}

resource "aws_cloudformation_stack_set_instance" "security-audit-cspm-stackset-instance" {
  stack_set_instance_region = var.region
  stack_set_name = aws_cloudformation_stack_set.security-audit-cspm-stackset.name
  call_as        = "DELEGATED_ADMIN"

  deployment_targets {
    organizational_unit_ids = [ var.organization_root_id ]
  }

  depends_on = [aws_cloudformation_stack_set.security-audit-cspm-stackset]
}