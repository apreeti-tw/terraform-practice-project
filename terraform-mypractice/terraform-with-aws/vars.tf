variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"
  default = {
    ap-south-1 = "ami-03cfb5e1fb4fac428"
  }
}

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}