resource "aws_instance" "rds-jumphost-instance" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id = aws_subnet.main-public-subnet-1.id
  key_name = aws_key_pair.myrdskey.key_name
  tags = {
    Name = "rds-jumphost-instance"
  }
}