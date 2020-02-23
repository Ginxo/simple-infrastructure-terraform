resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "${var.environment}-vpc-link"
  description = "The vpc link"
  target_arns = [var.lb_arn]
}