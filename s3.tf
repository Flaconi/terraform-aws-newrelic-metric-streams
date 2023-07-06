locals {
  s3_bucket_name = "${var.name}-s3-bucket-${random_string.this.id}"
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

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
