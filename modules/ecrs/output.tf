output "ecr_dns" {
  value = aws_ecr_repository.user_ecr_repository.repository_url
}