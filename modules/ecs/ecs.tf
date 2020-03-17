resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.environment}-cluster"

  capacity_providers = [
    aws_ecs_capacity_provider.ecs_cp.name
  ]
}