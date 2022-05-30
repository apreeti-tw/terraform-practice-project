resource "aws_security_group" "access-rules-sg" {
  vpc_id = aws_vpc.main.id
  name = "access-rules-sg"
  description = "Allow access to ec2 instances"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 9200
    protocol = "tcp"
    to_port = 9200
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5601
    protocol = "tcp"
    to_port = 5601
    cidr_blocks = ["0.0.0.0/0"]
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

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
