resource "aws_lb_target_group" "lb_target_group" {
  name_prefix = "${substr(var.environment, 0, 3)}-"
  port     = 8080
  protocol = "TCP"
  vpc_id   = aws_vpc.main-vpc.id
  target_type = "ip"

  stickiness {
    enabled = false
    type = "lb_cookie"
  }
  depends_on = [aws_lb.lb]
}