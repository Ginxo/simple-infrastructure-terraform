terraform {
  backend "s3" {
    bucket = "sercore-terraform"
    key = "staging"
    region = "eu-west-1"
  }
}

output "public-ip-staging" {
  value = module.ec2.instance_public_ip
}

# Specify the provider and access details
provider "aws" {}

module "rds" {
  source = "../../modules/rds"

  project_name = "sercore"
  environment = "staging"
  db_user_name = "dbuserstaging"
  db_password = "123456789"
}

module "ec2" {
  source = "../../modules/ec2"

  environment = "staging"
  vpc_default = "vpc-410de238"
}