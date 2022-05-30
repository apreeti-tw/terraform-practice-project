resource "aws_instance" "selenium-grid-hub" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-public-subnet-1.id
  tags = {
    Name = "selenium-grid-hub"
  }
  security_groups = [aws_security_group.allow-ssh.id]
  key_name = aws_key_pair.vpckey.key_name
}

resource "aws_instance" "selenium-worker-node-1" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-private-subnet-1.id
  tags = {
    Name = "selenium-worker-node-1"
  }
  security_groups = [aws_security_group.allow-ssh.id]
}

resource "aws_instance" "selenium-worker-node-2" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-private-subnet-1.id
  tags = {
    Name = "selenium-worker-node-2"
  }
  security_groups = [aws_security_group.allow-ssh.id]
}

output "ip-hub" {
  value = aws_instance.selenium-grid-hub.public_ip
}