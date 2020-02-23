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


output "ecr_dns" {
  value = module.ecr.ecr_dns
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "lb_arn" {
  value = module.ecs.lb_arn
}

output "lb_dns" {
  value = module.ecs.lb_dns
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.g_project_name
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.g_project_name
  environment = var.environment
  db_user_name = var.db_user_name
  db_password = var.db_password
}

module "ecs" {
  source = "../../modules/ecs"

  environment = var.environment
  project_name = var.g_project_name
  db_user_name = var.db_user_name
  db_password = var.db_password
  aws_region = var.aws_region
  ecr_dns = module.ecr.ecr_dns
  db_endpoint = module.rds.db_endpoint
}

module "api" {
  source = "../../modules/api"

  environment = var.environment
  project_name = var.g_project_name
  lb_arn = module.ecs.lb_arn
  lb_dns = module.ecs.lb_dns
}

/*output "public-ip-staging" {
  value = module.ec2.instance_public_ip
}

module "ec2" {
  source = "../../modules/ec2"

  public_key = var.public_key
  environment = var.environment
}

module "elb" {
  source = "../../modules/elb"

  public_key = var.public_key
  project_name = var.g_project_name
  environment = var.environment
}
*/