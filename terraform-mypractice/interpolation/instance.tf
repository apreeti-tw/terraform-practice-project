resource "aws_instance" "ubuntu-instance" {
  ami = var.AMIS
  instance_type = "t2.micro"

  subnet_id = var.ENV == "prod"?module.vpc-prod.public_subnets[0]:module.vpc-dev.public_subnets[0]

  vpc_security_group_ids = [var.ENV == "prod"?aws_security_group.allow-ssh-prod.id:aws_security_group.allow-ssh-dev.id]

  key_name = aws_key_pair.interpolation-key.key_name

  tags = {
    Name = "${var.ENV}-instance"
  }
}
