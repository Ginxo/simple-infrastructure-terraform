output "ecr_dns" {
  value = aws_ecr_repository.ecr_repository.repository_url
}