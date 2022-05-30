resource "aws_elb" "main-elb" {
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }
  name = "main-elb"
  security_groups = [aws_security_group.elb-sg.id]
  subnets = [aws_subnet.main-public-subnet-1.id, aws_subnet.main-public-subnet-2.id]

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
    Name = "main-elb"
  }
}
