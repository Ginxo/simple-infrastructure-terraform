resource "aws_security_group" "allow_rds_connection" {
  name        = "allow_rds_connection"
  description = "Allow RDS inbound traffic"
  vpc_id      = var.vpc_main_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
