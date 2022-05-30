variable "AWS_REGION" {
  type = "map"
  default = {
    ap-south-1a = "ap-south-1a"
    ap-south-1b = "ap-south-1b"
  }
}

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}