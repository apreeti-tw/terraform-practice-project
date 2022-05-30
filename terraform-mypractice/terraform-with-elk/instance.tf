resource "aws_instance" "elasticsearch-hub" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.medium"
  subnet_id = aws_subnet.main-public-subnet-1.id
  tags = {
    Name = "elasticsearch-hub"
  }
  security_groups = [aws_security_group.access-rules-sg.id]
  key_name = aws_key_pair.kp.key_name

  provisioner "file" {
    connection {
      type = "ssh"
      host = coalesce(self.public_ip, self.private_ip)
      user = var.INSTANCE_USER
      private_key = tls_private_key.pk.private_key_pem
    }

    source = "../docker-compose-elk.yml"
    destination = "/home/ec2-user/docker-compose-elk.yml"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = coalesce(self.public_ip, self.private_ip)
      user = var.INSTANCE_USER
      private_key = tls_private_key.pk.private_key_pem
    }

    inline = [
      "sudo yum install -y docker",
      "sudo service docker start",
      "sudo mkdir esdata",
      "sudo chown 1000:1000 esdata",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose",
      "sudo docker-compose -f docker-compose-elk.yml up -d"
    ]
  }
}

output "ip_hub" {
  value=aws_instance.elasticsearch-hub.public_ip
}
