resource "aws_ecs_cluster" "main-${var.environment}" {
  name = "ecs_cluster-${var.environment}"
}

data "template_file" "task_definition-${var.environment}" {
  template = "${file("${path.module}/templates/tasks/aws1.json")}"

  vars {
    image_url           = "525334852292.dkr.ecr.eu-west-1.amazonaws.com/devel"
    container_name      = "aws1-${var.environment}"
    log_group_region    = "${var.aws_region}"
    log_group_name      = "${aws_cloudwatch_log_group.app.name}"
    ACTIVE_PROFILE      = "${var.environment}"
    DATABASE_DIALECT    = "${var.db_dialect}"
    DATASOURCE_URL      = "${var.db_url}"
    DATASOURCE_USERNAME = "${var.db_user_name}"
    DATASOURCE_PASSWORD = "${var.db_password}"
  }
}

resource "aws_ecs_task_definition" "aws1-${var.environment}" {
  family                = "aws1-${var.environment}"
  container_definitions = "${data.template_file.task_definition-${var.environment}.rendered}"
}

resource "aws_ecs_service" "service-${var.environment}" {
  name            = "tf-ecs-aws1-${var.environment}"
  cluster         = "${aws_ecs_cluster.main-${var.environment}.id}"
  task_definition = "${aws_ecs_task_definition.aws1-${var.environment}.arn}"
  desired_count   = 2
  iam_role        = "${aws_iam_role.ecs_service.name}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.${var.environment}.id}"
    container_name   = "aws1-${var.environment}"
    container_port   = "8080"
  }

  depends_on = [
    "aws_iam_role_policy.ecs_service"
  ]
}