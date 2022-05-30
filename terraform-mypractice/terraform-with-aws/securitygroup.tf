resource "aws_security_group" "allow-ssh" {
  vpc_id = aws_vpc.main.id
  name = "allow-ssh"
  description = "Allow ssh access to ec2 instances"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["115.98.228.108/32"]
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