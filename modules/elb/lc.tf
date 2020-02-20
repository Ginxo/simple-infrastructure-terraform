resource "aws_launch_configuration" "web" {
  name_prefix   = "${var.project_name}-config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  security_groups = [
    aws_security_group.allow_ssh_anywhere.id,
    aws_security_group.allow_http_anywhere.id
  ]

  user_data = file("modules/elb/userData.txt")

  lifecycle {
    create_before_destroy = true
  }
}
