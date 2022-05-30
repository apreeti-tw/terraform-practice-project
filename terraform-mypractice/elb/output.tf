output "elb-ip" {
  value = aws_elb.main-elb.dns_name
}
