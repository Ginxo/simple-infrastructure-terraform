resource "aws_lb_target_group" "lb_target_group" {
  name_prefix = "lb-"
  port     = 8080
  protocol = "TCP"
  vpc_id   = data.aws_vpc.selected.id

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  depends_on = [aws_lb.lb]
}