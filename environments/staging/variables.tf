variable "g_project_name" {
  description = "The project name"
}

variable "public_key" {
  description = "The ssh public key"
}

variable "environment" {
  description = "The environment"
  default = "staging"
}

variable "db_user_name" {
  description = "The database user name"
}

variable "db_password" {
  description = "The database password"
}

variable "aws_region" {
  description = "The aws region"
}
