resource "aws_ecs_capacity_provider" "ecs-cp" {
  name = "${var.environment}-ecs-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.web.arn
    managed_termination_protection = "DISABLED"
  }
}