resource "aws_iam_user" "admin_user" {
  name = "yatharth"
  tags = {
    Description = "Admin user"
  }
}

resource "aws_iam_policy" "admin_full_access_user" {
  name   = "aws-admin-user"
  policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.admin_full_access_user.arn
}

resource "aws_iam_user" "jenkins_user" {
  name = "yatharth"
  tags = {
    Description = "Jenkins user"
  }
}

resource "aws_iam_policy" "ec2_full_access_user" {
  name   = "aws-ec2-user"
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "ec2:*",
                "Resource": "*"
            }
        ]
    }
    EOF
}

resource "aws_iam_user_policy_attachment" "ec2_policy_attachment" {
  user       = aws_iam_user.jenkins_user.name
  policy_arn = aws_iam_policy.ec2_full_access_user.arn
}
