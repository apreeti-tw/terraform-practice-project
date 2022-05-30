resource "aws_instance" "remote-state" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  tags = {
    Name = "remote-state"
  }
}