resource "aws_db_subnet_group" "rds-subnet-group" {
  subnet_ids = [aws_subnet.main-private-subnet-1.id, aws_subnet.main-private-subnet-2.id]
  name = "rds-subnet-group"
}

resource "aws_db_parameter_group" "rds-parameter-group" {
  family = "mariadb10.1"
  name = "rds-parameter-group"
  parameter {
    name = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "rds-instance" {
  instance_class = "db.t2.micro"
  allocated_storage = 100
  parameter_group_name = aws_db_parameter_group.rds-parameter-group.name
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  username = "root"
  password = var.RDS_PASSWORD
  vpc_security_group_ids = [aws_security_group.allow-rds.id]
  availability_zone = aws_subnet.main-private-subnet-1.availability_zone
  multi_az = "false"
  engine = "mariadb"
  engine_version = "10.1.14"
  identifier = "mariadb"
  name = "mariadb"
  storage_type = "gp2"
  backup_retention_period = 30
  skip_final_snapshot = "true"
  tags = {
    Name = "rds-instance"
  }
}