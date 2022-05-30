resource "aws_security_group" "instance-sg" {
  name = "instance-sg"
  tags = {
    Name = "instance-sg"
  }
  vpc_id = aws_vpc.main-vpc.id
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    security_groups = [aws_security_group.elb-sg.id]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["60.243.234.122/32"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb-sg" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "elb-sg"
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
