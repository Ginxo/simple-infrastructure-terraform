resource "aws_lb" "lb" {
  name = "${var.environment}-lb"
  internal = false
  load_balancer_type = "network"
  subnets = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  tags = {
    Environment = var.environment
  }
}