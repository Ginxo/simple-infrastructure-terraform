output "db_endpoint" {
  value = aws_db_instance.rds_db.endpoint
}

output "rds_connection_security_group_id" {
  value = aws_security_group.allow_rds_connection.id
}