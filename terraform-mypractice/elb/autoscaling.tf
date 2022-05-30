resource "aws_launch_configuration" "elb-instance-launch-config" {
  image_id = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  security_groups = [
    aws_security_group.instance-sg.id]
  key_name = aws_key_pair.elbkey.key_name
  name_prefix = "elb-instance"
  lifecycle {
    create_before_destroy = true
  }
  user_data = "#! /bin/sh\nsudo su\nyum -y install nginx\nservice nginx start\nrm /usr/share/nginx/html/index.html\necho 'this is: '$(hostname -I) >> /usr/share/nginx/html/index.html"
}

resource "aws_autoscaling_group" "elb-autoscaling-group" {
  max_size = 2
  min_size = 2
  vpc_zone_identifier = [aws_subnet.main-public-subnet-1.id, aws_subnet.main-public-subnet-2.id]
  launch_configuration = aws_launch_configuration.elb-instance-launch-config.id
  health_check_grace_period = 400
  health_check_type = "ELB"
  load_balancers = [aws_elb.main-elb.name]
  force_delete = true
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "ec2 instance"
  }
}
