data "template_file" "user_task_template" {
  template = file("./resources/templates/tasks/template.json")
  vars = {
    image_url = "${var.ecr_dns}:${var.ecr_image_version}"
    container_name = "user_container"
    ACTIVE_PROFILE = var.environment
    DATABASE_DIALECT = ""
    DATASOURCE_URL = var.db_endpoint
    DATASOURCE_USERNAME = var.db_user_name
    DATASOURCE_PASSWORD = var.db_password
    DATASOURCE_DB_NAME = "${var.project_name}${var.environment}"
    log_group_region = var.aws_region
    log_group_name   = aws_cloudwatch_log_group.cloud_watch.name
  }
}

resource "aws_ecs_task_definition" "user_task_definition" {
  family = "user_task_definition"
  container_definitions = data.template_file.user_task_template.rendered

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn

  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512
  network_mode = "awsvpc"
}