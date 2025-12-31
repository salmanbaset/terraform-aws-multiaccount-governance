data "aws_iam_policy_document" "deny_identity_center_instances_policy" {
  statement {
    effect    = "Deny"
    actions   = [
      "sso:CreateInstance"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotEquals"
      variable = "aws:PrincipalAccount"
      values   = [var.management_account_id]
    }
  }
}

resource "aws_organizations_policy" "deny_identity_center_instances_policy" {
  name    = "deny_identity_center_instances_policy"
  content = data.aws_iam_policy_document.deny_identity_center_instances_policy.json
}

# Attach the SCP policy to the root of the organization
resource "aws_organizations_policy_attachment" "attach_deny_identity_center_instances_policy" {
  policy_id = aws_organizations_policy.deny_identity_center_instances_policy.id
  target_id = var.organization_root_id
}

output "deny_identity_center_instances_policy" {
  value = data.aws_iam_policy_document.deny_identity_center_instances_policy.json  
}