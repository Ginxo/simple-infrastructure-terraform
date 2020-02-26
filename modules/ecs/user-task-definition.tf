data "template_file" "user_task_template" {
  template = file("./resources/templates/tasks/template.json")
  vars = {
    // TODO check the image name and database url
    image_url = "${var.ecr_dns}:${var.ecr_image_version}"
    container_name = "user_container"
    ACTIVE_PROFILE = var.environment
    DATABASE_DIALECT = ""
    DATASOURCE_URL = var.db_endpoint
    DATASOURCE_USERNAME = var.db_user_name
    DATASOURCE_PASSWORD = var.db_password
    log_group_region = var.aws_region
    log_group_name   = aws_cloudwatch_log_group.app.name
  }
}

resource "aws_ecs_task_definition" "user_task_definition" {
  family = "user_task_definition"
  container_definitions = data.template_file.user_task_template.rendered
}