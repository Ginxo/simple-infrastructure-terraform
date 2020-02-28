data "aws_ami" "amazon_ecs" {
  most_recent = true
  owners = [
    "amazon"
  ]

  filter {
    name   = "name"
    values = ["amzn-ami-${var.ami_version}-amazon-ecs-optimized"]
  }
}

data "template_file" "lc_user_data" {
  template = file("./resources/userData/asg-user-data.txt")
  vars = {
    // TODO AML view how linked the cluster name with the terraform reference, if we do it cycle error raised in terraform
    cluster_name = "${var.environment}-cluster"
    additional_user_data_script = ""
    docker_storage_size         = 22
    dockerhub_token             = ""
    dockerhub_email             = ""
  }
}

resource "aws_launch_configuration" "web" {
  name_prefix = "${var.project_name}-config"
  image_id = data.aws_ami.amazon_ecs.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  security_groups = [
    aws_security_group.allow_http_anywhere.id,
    aws_security_group.allow_ssh_anywhere.id,
    var.db_connection_security_group_id
  ]

  user_data = data.template_file.lc_user_data.rendered

  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.id

  lifecycle {
    create_before_destroy = true
  }
}
