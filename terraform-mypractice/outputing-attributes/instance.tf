resource "aws_instance" "outputing-attributes" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  tags = {
    Name= "outputing-attributes"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.outputing-attributes.public_ip} >> public_ips.txt"
  }
}

output "ip" {
  value = aws_instance.outputing-attributes.public_ip
}