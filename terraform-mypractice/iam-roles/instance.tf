data "aws_ip_ranges" "ap-ip-ranges" {
  services = ["ec2"]
  regions = [var.AWS_REGION]
}

resource "aws_instance" "example" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.mys3instancekey.key_name
  iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instance-profile.id
  security_groups = [aws_security_group.example-sg.name]
}

resource "aws_key_pair" "mys3instancekey" {
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  key_name = "mys3instancekey"
}

resource "aws_security_group" "example-sg" {
  name = "example-sg"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = data.aws_ip_ranges.ap-ip-ranges.cidr_blocks
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}