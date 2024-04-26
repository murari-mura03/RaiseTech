#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

resource "aws_s3_bucket" "s3" {
  bucket = "${var.name}-mura03-s3"
}

#--------------------------------------------------------------
# S3 ACL
#--------------------------------------------------------------

resource "aws_s3_bucket_ownership_controls" "s3_acl" {
  bucket = aws_s3_bucket.s3.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

#--------------------------------------------------------------
# Bucket policy
#--------------------------------------------------------------

resource "aws_s3_bucket_policy" "allow_access_s3" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.allow_access_s3.json
}

data "aws_iam_policy_document" "allow_access_s3" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.role_arn]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.s3.arn,
      "${aws_s3_bucket.s3.arn}/*",
    ]
  }
}
