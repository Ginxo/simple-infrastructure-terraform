data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_lb" "lb" {
  name = "${var.environment}-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.allow_http_anywhere.id]
  subnets = data.aws_subnet_ids.selected.ids

  tags = {
    Environment = var.environment
  }
}