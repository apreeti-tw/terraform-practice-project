variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  default = "ami-03cfb5e1fb4fac428"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../../keys/mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "../../keys/mykey"
}

variable "ENV" {
  default = "prod"
}
