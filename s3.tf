locals {
  s3_bucket_name = "${var.name}-s3-bucket-${random_string.this.id}"
}

# ------------------------------------------------------------------------------------------------
# S3 Bucket Policy
# ------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "bucket" {
  count = var.attach_deny_insecure_transport_policy ? 1 : 0

  # ISO 27001:2022
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type = "*"
    }
    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/*",
      "arn:aws:s3:::${local.s3_bucket_name}",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = ["false"]
    }
  }
}

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "this" {
  bucket        = local.s3_bucket_name
  tags          = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_policy" "this" {
  count = var.attach_deny_insecure_transport_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.bucket[0].json
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
