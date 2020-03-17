resource "aws_ecr_repository" "user_ecr_repository" {
  name                 = "user"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}