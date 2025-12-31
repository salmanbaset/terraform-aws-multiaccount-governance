data "aws_iam_policy_document" "deny_accounts_leaving_policy" {
  statement {
    effect    = "Deny"
    actions   = [
      "organizations:LeaveOrganization"
    ]
    resources = ["*"]
  }
}

# Create the SCP policy to deny accounts from leaving the organization
resource "aws_organizations_policy" "deny_accounts_leaving_policy" {
  name    = "deny_accounts_leaving_policy"
  content = data.aws_iam_policy_document.deny_accounts_leaving_policy.json
}

# Attach the SCP policy to the root of the organization
resource "aws_organizations_policy_attachment" "attach_deny_accounts_leaving_policy" {
  policy_id = aws_organizations_policy.deny_accounts_leaving_policy.id
  target_id = var.organization_root_id
}

output "deny_accounts_leaving_policy" {
  value = data.aws_iam_policy_document.deny_accounts_leaving_policy.json  
}