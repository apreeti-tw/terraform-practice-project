data "aws_ip_ranges" "asia-pacific-ip-ranges" {
  services = ["ec2"]
  regions  = [var.AWS_REGION.ap-south-1, var.AWS_REGION.ap-south-2]
}

resource "aws_security_group" "asia-pacific-sg" {
  name = "asia-pacific-sg"

  ingress {
    from_port   = "443"
    protocol    = "tcp"
    to_port     = "443"
    cidr_blocks = data.aws_ip_ranges.asia-pacific-ip-ranges.cidr_blocks
  }

  tags = {
    CreateDate = data.aws_ip_ranges.asia-pacific-ip-ranges.create_date
    SyncToken  = data.aws_ip_ranges.asia-pacific-ip-ranges.sync_token
  }
}

