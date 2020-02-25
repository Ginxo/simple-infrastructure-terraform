terraform {
  backend "s3" {
    bucket = "sercore-terraform"
    key = "staging"
    region = "eu-west-1"
    // TODO create TerraformLock DynamoDb
    //dynamodb_table = "TerraformLock"
  }
}

# Specify the provider and access details
provider "aws" {}

module "ecr" {
  source = "../../modules/ecr"
}

module "ecs" {
  source = "../../modules/ecs"

  environment = var.environment
  project_name = var.g_project_name
  public_key = var.public_key
  db_user_name = var.db_user_name
  db_password = var.db_password
  aws_region = var.aws_region
  ecr_dns = module.ecr.ecr_dns
  //db_endpoint = module.rds.db_endpoint
  db_endpoint = "endpoint"
}

/*
module "rds" {
  source = "../../modules/rds"

  project_name = var.g_project_name
  environment = var.environment
  db_user_name = var.db_user_name
  db_password = var.db_password
}

module "api" {
  source = "../../modules/api"

  environment = var.environment
  project_name = var.g_project_name
  lb_arn = module.ecs.lb_arn
  lb_dns = module.ecs.lb_dns
}
*/