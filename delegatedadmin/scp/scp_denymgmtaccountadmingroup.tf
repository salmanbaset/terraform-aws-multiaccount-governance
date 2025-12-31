# data "aws_iam_policy_document" "deny_amgmtaccount_admin_group_changes_policy" {
#   statement {
#     effect    = "Deny"
#     actions   = [
#                 "identitystore:UpdateGroup",
#                 "identitystore:DeleteGroup",
#                 "identitystore:CreateGroupMembership",
#                 "identitystore:DeleteGroupMembership",
#                 "sso-directory:UpdateGroup",
#                 "sso-directory:AddMemberToGroup",
#                 "sso-directory:RemoveMemberFromGroup",
#                 "sso-directory:DeleteGroup"]
#     resources = ["*"]
#     condition {
#       test     = "StringEquals"
#       variable = "identitystore:GroupId"
#       values   = ["XXXXXXXXXXXXXXX"]  # REPLACE WITH YOUR MGMT ACCOUNT IDENTITY STORE ADMIN GROUP ID
#     }
#   }
# }

# # Create the SCP policy to deny accounts from leaving the organization
# resource "aws_organizations_policy" "deny_mgmt_account_admin_group_changes_policy" {
#   name    = "deny_mgmt_account_admin_group_changes_policy"
#   content = data.aws_iam_policy_document.deny_amgmtaccount_admin_group_changes_policy.json
# }

# # Attach the SCP policy to the root of the organization
# resource "aws_organizations_policy_attachment" "attach_deny_mgmt_account_admin_group_changes_policy" {
#   policy_id = aws_organizations_policy.deny_mgmt_account_admin_group_changes_policy.id
#   target_id = var.organization_root_id
# }
