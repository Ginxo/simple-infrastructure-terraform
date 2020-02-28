resource "aws_db_instance" "rds-db" {
  identifier = "${var.project_name}-${var.environment}"
  allocated_storage = "20"
  engine = "mysql"
  engine_version = "5.7.28"
  instance_class = "db.t2.small"
  name = "${var.project_name}${var.environment}"
  username = var.db_user_name
  password = var.db_password
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [
    aws_security_group.allow_rds_connection.id
  ]
}