terraform {
  backend "s3" {
    bucket = "terraform-state-2106"
    key = "terraform/remote-state"
    region = "ap-south-1"
  }
}