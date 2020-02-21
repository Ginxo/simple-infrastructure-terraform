resource "aws_lb_target_group" "lb_target_group" {
  name     = "${var.environment}-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
}