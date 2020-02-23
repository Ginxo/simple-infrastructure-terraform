data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_lb" "lb" {
  name = "${var.environment}-lb"
  internal = false
  load_balancer_type = "network"
  subnets = data.aws_subnet_ids.selected.ids

  tags = {
    Environment = var.environment
  }
}