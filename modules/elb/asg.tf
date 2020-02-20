data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_autoscaling_group" "web" {
  name                      = "${var.project_name}-group"
  max_size                  = 2
  min_size                  = 0
  desired_capacity          = 0
  launch_configuration      = "${aws_launch_configuration.web.name}"
  
  //todo hacer datasource
  vpc_zone_identifier       = ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"]

  tag {
    key                 = "name"
    value               = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}