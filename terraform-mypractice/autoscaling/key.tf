resource "aws_key_pair" "myautoscalingkey" {
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  key_name = "myautoscalingkey"
}