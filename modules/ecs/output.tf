output "lb_arn" {
  value = aws_lb.lb.arn
}

output "lb_dns" {
  value = aws_lb.lb.dns_name
}

output "vpc_main_id" {
  value = aws_vpc.main-vpc.id
}

output "vpc_private_subnet_ids" {
  value = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
}