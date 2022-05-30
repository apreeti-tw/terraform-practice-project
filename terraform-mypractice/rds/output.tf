output "jumphost-ip" {
  value = aws_instance.rds-jumphost-instance.public_ip
}

output "rds-instance-endpoint" {
  value = aws_db_instance.rds-instance.endpoint
}