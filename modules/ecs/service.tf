resource "aws_ecs_service" "user-service" {
  name            = "user-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.user_task_definition.arn
  desired_count   = 3
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 100

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = "user_container"
    container_port   = 8080
  }
}