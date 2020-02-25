data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  owners = [
    "099720109477"
  ]
}

resource "aws_launch_configuration" "web" {
  name_prefix = "${var.project_name}-config"
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  security_groups = [
    aws_security_group.allow_http_anywhere.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}
