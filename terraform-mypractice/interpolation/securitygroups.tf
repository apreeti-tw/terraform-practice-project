resource "aws_security_group" "allow-ssh-dev" {
  name = "allow-ssh-dev"
  tags = {
    Name = "allow-ssh-dev"
  }
  vpc_id = module.vpc-dev.vpc_id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["27.6.179.51/32"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-ssh-prod" {
  name = "allow-ssh-prod"
  tags = {
    Name = "allow-ssh-prod"
  }
  vpc_id = module.vpc-prod.vpc_id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["27.6.179.51/32"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
