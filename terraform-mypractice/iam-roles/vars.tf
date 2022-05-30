variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"
  default = {
    ap-south-1 = "ami-03cfb5e1fb4fac428"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "/Users/apreeti/Documents/TerraformPracticeProject/keys/mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/Users/apreeti/Documents/TerraformPracticeProject/keys/mykey"
}