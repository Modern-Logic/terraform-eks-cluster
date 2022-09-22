module "main" {
  source                                   = "./eks-app"
  company_name                             = var.company_name
  environment                              = var.environment
  region                                   = var.region
  app_vpc_cidr                             = var.app_vpc_cidr
  initial_database                         = var.initial_database
  master_db_username                       = var.master_db_username
  master_db_password                       = var.master_db_password
  kms_grantees                             = var.kms_grantees
  snapshot_identifier                      = var.snapshot_identifier
  alarms_email_recipients                  = var.alarms_email_recipients
  server_iam_role_policy_statements        = var.server_iam_role_policy_statements
  skip_final_snapshot                      = var.skip_final_snapshot
  deploy_read_replica                      = var.deploy_read_replica
  database_security_group_additional_rules = var.database_security_group_additional_rules
  services_to_grant_kms_access_to          = var.services_to_grant_kms_access_to
  create_vpc                               = var.create_vpc
  vpc_id                                   = var.vpc_id
  private_subnet_ids                       = var.private_subnet_ids
  public_subnet_ids                        = var.public_subnet_ids
  deploy_eks                               = var.deploy_eks
  web_eks_port                             = var.web_eks_port
  docs_eks_port                            = var.docs_eks_port
  api_eks_port                             = var.api_eks_port
  use_variable_scripts                     = var.use_variable_scripts
  certificate_arn                          = var.certificate_arn
  database_instance_type                   = var.database_instance_type
  eks_cluster_name                         = var.eks_cluster_name
  app_name                                 = var.app_name
  iam_arns_to_grant_sns_kms_access_to      = var.iam_arns_to_grant_sns_kms_access_to
  use_only_private_subnets                 = var.use_only_private_subnets
  tags = {
    Company           = var.company_name
    Deployment_Method = "terraform"
    Environment       = var.environment
  }
}