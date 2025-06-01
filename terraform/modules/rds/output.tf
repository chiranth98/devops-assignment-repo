output "rds_endpoint" {
  value = { for db, inst in aws_db_instance.rds : db => inst.endpoint }
}
