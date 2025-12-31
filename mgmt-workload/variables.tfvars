############################################
# AWS Provider Variables
############################################
# AWS profile to use
profile = "mgmt-admin"  # ADD YOUR SECURITY LOGGING ACCOUNT ADMIN USER PROFILE
region = "us-east-2"


#################################################################
# Management Account, Identity Center, and Workload OU variables
#################################################################
# Management Account Information
management_account_id = ""  # ADD MANAGEMENT ACCOUNT ID, e.g., 123456789012

# Identity Center ARN
identity_center_arn = ""  # ADD IDENTITY CENTER INSTANCE ARN HERE, e.g., arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxxx

# Workload OU ID
workload_ou_id = ""  # ADD WORKLOAD OU ID HERE, e.g., ou-xxxx-xxxxxxxx
#################################################################


############################################
# Workload Account Variables
############################################
# Dev Account Variables. Email address and Account name
dev_account_email = ""  # ADD DEV ACCOUNT EMAIL, e.g., awsaccounts+devaccount@acme.com
dev_account_name = "Development Account"

# Production Account Variables. Email address and Account name
production_account_email = ""  # ADD PRODUCTION ACCOUNT EMAIL, e.g., awsaccounts+productionaccount@acme.com
production_account_name = "Production Account"
############################################


############################################
# Group and Permission Set Variables
############################################

security_analysts_group_id = ""  # ADD SECURITY ANALYST GROUP ID HERE, e.g., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
security_analyst_permission_set_arn = ""  # ADD SECURITY ANALYST PERMISSION SET ARN HERE, e.g., arn:aws:sso:::permissionSet/ssoins-xxxxxxxxxxxxxxxx/ps-xxxxxxxxxxxxxxxx

developers_group_id = ""  # ADD DEVELOPER GROUP ID HERE, e.g., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
developer_permission_set_arn = ""  # ADD DEVELOPER PERMISSION SET ARN HERE, e.g., arn:aws:sso:::permissionSet/ssoins-xxxxxxxxxxxxxxxx/ps-xxxxxxxxxxxxxxxx

workload_administrators_group_id = ""  # ADD WORKLOAD ADMINS GROUP ID HERE, e.g., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
workload_administrator_permission_set_arn = ""  # ADD WORKLOAD ADMINISTRATOR PER, e.g., arn:aws:sso:::permissionSet/ssoins-xxxxxxxxxxxxxxxx/ps-xxxxxxxxxxxxxxxx
############################################