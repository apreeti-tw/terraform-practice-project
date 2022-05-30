resource "aws_instance" "example" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.key_name
  tags = {
    Name="example"
  }

  connection {
    type = "ssh"
    host = coalesce(self.public_ip, self.private_ip)
    user = var.INSTANCE_USER
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  provisioner "file" {
    source = "scripts.sh"
    destination = "/home/ec2-user/scripts.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/scripts.sh",
      "sudo /home/ec2-user/scripts.sh",
    ]
  }
}

resource "aws_key_pair" "mykey" {
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  key_name = "mykey"
}
