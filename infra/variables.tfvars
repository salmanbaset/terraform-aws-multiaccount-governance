# AWS profile to use
profile = "infra-admin"  # ADD YOUR INFRA ENVIRONMENT ADMINISTRATOR USER PROFILE
region = "us-east-2"

###########################################
# Stackset variables
###########################################
trusted_account_id = ""  # LEAVE EMPTY, WILL BE SET AUTOMATICALLY
trusted_role_arn   = ""  # ADD YOUR INFRA ENVIRONMENT ADMINISTRATOR USER ROLE ARN SO THAT IT CAN ASSUME security-cspm ROLE FROM CSPM (PROWLER) IN ALL ACCOUNTS FROM LOCAL MACHINE