#--------------------------------------------------------------
# IAM policy
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_role" "ec2_instance_role" {
  name               = "EC2InstanceRole"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "S3FullAccessPolicy"
  description = "Allows full access to S3"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "s3:*"
      Resource  = "*"
    }]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_policy_attachment" "s3_full_access_attachment" {
  name       = "S3FullAccessAttachment"
  roles      = [aws_iam_role.ec2_instance_role.name]
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}
