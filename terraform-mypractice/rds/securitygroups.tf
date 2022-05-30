resource "aws_security_group" "allow-ssh" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["115.98.23.197/32"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_security_group" "allow-rds" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = [aws_security_group.allow-ssh.id]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-rds"
  }
}