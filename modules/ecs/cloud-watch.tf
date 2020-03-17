resource "aws_cloudwatch_log_group" "cloud_watch" {
  name = "${var.project_name}/${var.environment}"
}