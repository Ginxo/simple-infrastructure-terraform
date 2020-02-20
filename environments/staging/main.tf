terraform {
  backend "s3" {
    bucket = "sercore-terraform"
    key = "staging"
    region = "eu-west-1"
  }
}

# Specify the provider and access details
provider "aws" {}

module "elb" {
  source = "../../modules/elb"

  project_name = "sercore"
  environment = "staging"
}
