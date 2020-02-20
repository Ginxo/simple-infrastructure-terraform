variable "public_key" {
  description = "The ssh public key"
}

variable "environment" {
  description = "The environment"
  default = "staging"
}

variable "g_project_name" {
  description = "The project name"
}