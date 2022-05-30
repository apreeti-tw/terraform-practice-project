resource "aws_s3_bucket" "my-s3-bucket-2106" {
  bucket = "my-s3-bucket-2106"
  acl = "private"
  tags = {
    Name = "my-s3-bucket-2106"
  }
}