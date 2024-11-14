resource "aws_iam_role" "bastion_role" {
  name = "${local.prefix}-bastionHost"
  assume_role_policy = jsonencode({
    Statement = [ {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
            Service = "ec2.amazonaws.com"
        }
    },]
  })
}

resource "aws_iam_instance_profile" "bastionHost_profile" {
  name = "bastionHost-instanceProfile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_policy" "bucket_access_policy" {
  name = "EC2-to-S3-AcessPolicy"
  description = "Allowing ec2 instance to access S3 bucket"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow"
        "Action": ["s3:GetObject", "s3:ListBucket"],
        "Resource": [
          "arn:aws:s3::${aws_s3_bucket.mys3bucket.arn}",
          "arn:aws:s3::${aws_s3_bucket.mys3bucket.arn}/*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "attach_to_bastion" {
  role = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.bucket_access_policy.arn
}
