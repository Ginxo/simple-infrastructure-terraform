terraform {
  backend "s3" {
    bucket = "sercore-terraform"
    key = "staging"
    region = "eu-west-1"
    // TODO create TerraformLock DynamoDb
    //dynamodb_table = "TerraformLock"
  }
}

output "public-ip-staging" {
  value = module.ec2.instance_public_ip
}

# Specify the provider and access details
provider "aws" {}

module "ec2" {
  source = "../../modules/ec2"

  public_key = var.public_key
  environment = var.environment
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.g_project_name
  environment = var.environment
  db_user_name = "dbuserstaging"
  db_password = "123456789"
}

module "elb" {
  source = "../../modules/elb"

  public_key = var.public_key
  project_name = var.g_project_name
  environment = var.environment
}
