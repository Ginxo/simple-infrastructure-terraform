resource "aws_autoscaling_group" "auto_sacling_group" {
  name = "${var.environment}-group"
  max_size = 2
  min_size = 0
  desired_capacity = 1
  launch_configuration = aws_launch_configuration.launch_configuration.name
  vpc_zone_identifier = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
  health_check_grace_period = 10
  // health check of the load balancer, avoid internal machine checks
  health_check_type = "ELB"

  tag {
    key = "name"
    value = "${var.environment}-web-asg"
    propagate_at_launch = true
  }
}
