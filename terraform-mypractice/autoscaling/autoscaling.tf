resource "aws_launch_configuration" "example-launch-instance" {
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  security_groups = [aws_security_group.example-security-group.id]
  key_name = aws_key_pair.myautoscalingkey.key_name
  name_prefix = "example-launch-instance"
}

resource "aws_autoscaling_group" "example-autoscaling-group" {
  name = "example-autoscaling-group"
  max_size = 2
  min_size = 1
  vpc_zone_identifier = [aws_subnet.main-public-subnet-1.id, aws_subnet.main-public-subnet-2.id]
  launch_configuration = aws_launch_configuration.example-launch-instance.id
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "ec2 instance"
  }
}