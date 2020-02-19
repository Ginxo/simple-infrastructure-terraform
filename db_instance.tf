resource "aws_db_instance" "rds-db" {
  identifier = "sistemastm-${var.environment}"
  allocated_storage = "20"
  engine = "mysql"
  engine_version = "5.7.28"
  instance_class = "db.t2.small"
  name = "sistemastm-${var.environment}"
  username = "${var.db_user_name}"
  password = "${var.db_password}"
  publicly_accessible = false
  vpc_security_group_ids = ["rds_security_group_id"]
  skip_final_snapshot = true
}