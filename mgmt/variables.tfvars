# Say your company is acme.com and you are setting up a new AWS
# Organization with a management account and several member accounts.
# This file contains the variable values for the management account setup.
# If you do not wish to use the your company domain, replace with your personal email address.

# AWS profile to use
profile = "rootuser"  # ADD YOUR ROOT USER PROFILE
region = "us-east-2"

# Management Account Import Prep
management_account_name = "Management Account"  # ADD YOUR MANAGEMENT ACCOUNT NAME, e.g., Acme Management Account
management_account_email = ""  # ADD MANAGEMENT ACCOUNT EMAIL (Ideally an email group), e.g., awsadmin@acme.com
management_account_id = ""  # ADD MANAGEMENT ACCOUNT ID, e.g., 123456789012

# role name for management account to assume
rolename_for_mgmt_account = "OrganizationAccountAccessRole"

############################################
# Governance OU Account Variables
############################################
# Delegated Admin Account Variables. Email address and Account name
delegated_admin_account_email = ""  # ADD DELEGATED ADMIN ACCOUNT EMAIL, e.g., awsaccounts+delegatedadminaccount@acme.com
delegated_account_name = "DelegatedAdminAccount"

# Infrastructure Account Variables. Email address and Account name
infrastructure_account_email = ""  # ADD INFRASTRUCTURE ACCOUNT EMAIL, e.g., awsaccounts+infrastructureaccount@acme.com
infrastructure_account_name = "InfrastructureAccount"
############################################


############################################
# Security OU Account Variables
############################################
# Security Logging Account Variables. Email address and Account name
security_logging_account_email = ""  # ADD SECURITY LOGGING ACCOUNT EMAIL, e.g., awsaccounts+securityloggingaccount@acme.com
security_logging_account_name = "SecurityLoggingAccount"
############################################



# User1 Admin1 email address
user1_admin1_email = ""  # ADD EMAIL FOR FIRST USER FOR IDENTITY CENTER, e.g., awsusers+user1admin1@acme.com