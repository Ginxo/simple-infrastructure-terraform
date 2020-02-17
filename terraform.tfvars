variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "access_key" {
  description = "The AWS access key."
}

variable "secret_key" {
  description = "The AWS secret key."
}

variable "environment" {
  description = "The Database Password."
  default     = "dev"
}

variable "instance_type" {
  default     = "t2.small"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable "db_dialect" {
  description = "The Database Dialect Class Reference."
}

variable "db_url" {
  description = "The Database URL."
}

variable "db_user_name" {
  description = "The Database Username."
}

variable "db_password" {
  description = "The Database Password."
}
