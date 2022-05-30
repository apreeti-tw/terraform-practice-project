resource "aws_iam_group" "ec2-s3-admins" {
  name = "ec2-s3-admins"
}

resource "aws_iam_policy_attachment" "ec2-s3-admins-attach" {
  name       = "ec2-s3-admins-attach"
  groups     = [aws_iam_group.ec2-s3-admins.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group_policy" "my-s3-policy" {
  name   = "my-s3-policy"
  group  = aws_iam_group.ec2-s3-admins.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": "*"
  }
  ]
}
EOF
}

resource "aws_iam_user" "ec2-s3-admin-1" {
  name = "ec2-s3-admin-1"
}

resource "aws_iam_user" "ec2-s3-admin-2" {
  name = "ec2-s3-admin-2"
}

resource "aws_iam_group_membership" "ec2-admin-group-membership" {
  group = aws_iam_group.ec2-s3-admins.name
  name  = "ec2-admin-group-membership"
  users = [aws_iam_user.ec2-s3-admin-1.name, aws_iam_user.ec2-s3-admin-2.name]
}