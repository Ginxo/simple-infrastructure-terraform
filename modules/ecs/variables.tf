variable "environment" {
  description = "The environment."
}

variable "project_name" {
  description = "The project name"
}

variable "public_key" {}

variable "ecr_dns" {}
variable "ecr_image_version" {}
variable "ami_version" {}

variable "db_user_name" {
  description = "The database user name"
}

variable "db_password" {
  description = "The database password"
}

variable "aws_region" {
  description = "The aws region"
}

variable "db_endpoint" {
  description = "The database endpoint"
}