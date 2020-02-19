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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  vpc_security_group_ids = [
    aws_security_group.allow_ssh_anywhere.id,
    aws_security_group.allow_http_anywhere.id
  ]

  user_data = file("modules/ec2/userData.txt")

  tags = {
    Name = "user-ec2"
  }
}