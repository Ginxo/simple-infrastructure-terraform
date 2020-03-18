resource "aws_ecs_capacity_provider" "ecs_cp" {
  name = "${var.environment}-ecs-capacity-provider-8"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.auto_sacling_group.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status = "DISABLED"
    }
  }
}