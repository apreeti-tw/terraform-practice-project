resource "aws_key_pair" "interpolation-key" {
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  key_name = "interpolation-key"
}
