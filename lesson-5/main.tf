resource "aws_s3_bucket" "main" {
  bucket = "${local.name}-bucket"

  tags = {
    Name = "${local.name}-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.main.id

  //public access
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "web_static" {
  bucket = aws_s3_bucket.main.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.policy.json

}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "PublicRead"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = [
        "*"
      ]
    }
  }

#  statement {
#    sid     = "AllowCloudFrontRead"
#    actions = [
#      "s3:GetObject"
#    ]
#    resources = [
#      aws_s3_bucket.main.arn,
#      "${aws_s3_bucket.main.arn}/*"
#    ]
#
#    principals {
#      type        = "Service"
#      identifiers = [
#        "cloudfront.amazonaws.com"
#      ]
#    }
#  }
}