data "aws_iam_policy_document" "deny_key_iam_role_deletion_policy" {
  statement {
    effect    = "Deny"
    actions   = [
        "iam:AttachRolePolicy",
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:DeleteRolePermissionsBoundary",
        "iam:DeleteRolePolicy",
        "iam:DetachRolePolicy",
        "iam:PutRolePermissionsBoundary",
        "iam:PutRolePolicy",
        "iam:UpdateAssumeRolePolicy",
        "iam:UpdateRole",
        "iam:UpdateRoleDescription"
    ]
    resources = [
      "arn:aws:iam::*:role/aws-controltower-*",
      "arn:aws:iam::*:role/*AWSControlTower*",
      "arn:aws:iam::*:role/stacksets-exec-*",
      "arn:aws:iam::*:role/OrganizationAccountAccessRole"
    ]
    condition {
      test = "ArnNotLike"
      variable = "aws:PrincipalArn"
      values = [
        "arn:aws:iam::*:role/AWSControlTowerExecution",
        "arn:aws:iam::*:role/stacksets-exec-*",
        "arn:aws:iam::*:role/OrganizationAccountAccessRole"
      ]
    }
  }
}

# Create the SCP policy to deny key roles from being deleted
resource "aws_organizations_policy" "deny_key_iam_role_deletion_policy" {
  name    = "deny_key_iam_role_deletion_policy"
  content = data.aws_iam_policy_document.deny_key_iam_role_deletion_policy.json
}

# Attach the SCP policy to the root of the organization
resource "aws_organizations_policy_attachment" "deny_key_iam_role_deletion_policy" {
  policy_id = aws_organizations_policy.deny_key_iam_role_deletion_policy.id
  target_id = var.organization_root_id
}

output "deny_key_iam_role_deletion_policy" {
  value = data.aws_iam_policy_document.deny_key_iam_role_deletion_policy.json  
}