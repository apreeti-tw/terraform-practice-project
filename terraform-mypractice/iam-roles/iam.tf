resource "aws_iam_role" "s3-mybucket-role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3-mybucket-role-policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::my-s3-bucket-2106",
        "arn:aws:s3:::my-s3-bucket-2106/*"
      ]
    }
  ]
}
EOF
  role = aws_iam_role.s3-mybucket-role.id
}

resource "aws_iam_instance_profile" "s3-mybucket-role-instance-profile" {
  role = aws_iam_role.s3-mybucket-role.id
  name = "s3-mybucket-role-instance-profile"
}