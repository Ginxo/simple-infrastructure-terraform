output "lb_arn" {
  value = aws_lb.lb.arn
}

output "lb_dns" {
  value = aws_lb.lb.dns_name
}