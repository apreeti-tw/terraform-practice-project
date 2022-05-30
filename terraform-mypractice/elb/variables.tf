variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIs" {
  type = "map"
  default = {
    ap-south-1 = "ami-03cfb5e1fb4fac428"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../../keys/mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "../../keys/mykey"
}

variable "AWS_SUB_REGION_1a" {
  default = "ap-south-1a"
}

variable "AWS_SUB_REGION_1b" {
  default = "ap-south-1b"
}

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}
