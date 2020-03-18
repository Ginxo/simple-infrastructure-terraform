resource "aws_lb" "lb" {
  name = "${var.environment}-lb"
  //TODO check internal true
  internal = false
  load_balancer_type = "network"
  subnets = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Environment = var.environment
  }
}