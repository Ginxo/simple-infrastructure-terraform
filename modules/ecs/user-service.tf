resource "aws_ecs_service" "user_service" {
  name            = "${var.environment}-user-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.user_task_definition.arn
  desired_count   = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 100
  launch_type = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_groups = [
      aws_security_group.allow_http_anywhere.id,
      aws_security_group.allow_ssh_anywhere.id,
      var.db_connection_security_group_id
    ]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = "user_container"
    container_port   = 8080
  }
}

resource "aws_appautoscaling_target" "autosaling" {
  max_capacity = 1
  min_capacity = 0
  resource_id = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.user_service.name}"
  role_arn           = aws_iam_role.ecs_service_role.arn
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
