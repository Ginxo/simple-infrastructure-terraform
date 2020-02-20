resource "aws_autoscaling_group" "web" {
  name = "${var.project_name}-group"
  max_size = 2
  min_size = 0
  desired_capacity = 0
  launch_configuration = aws_launch_configuration.web.name

  vpc_zone_identifier = data.aws_subnet_ids.selected.ids

  load_balancers = [
    aws_elb.web.name
  ]

  health_check_grace_period = 10
  // health check of the load balancer, avoid internal machine checks
  health_check_type = "ELB"

  tag {
    key = "name"
    value = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}
