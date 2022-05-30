#scale up
resource "aws_autoscaling_policy" "example-upscale-policy" {
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling-group.name
  name = "example-upscale-policy"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-upscale-alarm" {
  alarm_name = "example-upscale-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  period = "120"
  namespace = "AWS/EC2"
  statistic = "Average"
  threshold = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling-group.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.example-upscale-policy.arn]
}

#scale down
resource "aws_autoscaling_policy" "example-downscale-policy" {
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling-group.name
  name = "example-downscale-policy"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-downscale-alarm" {
  alarm_name = "example-downscale-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  period = "120"
  metric_name = "CPUUtilization"
  statistic = "Average"
  namespace = "AWS/EC2"
  threshold = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling-group.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.example-downscale-policy.arn]
}