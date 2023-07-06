locals {
  firehose_iam_role_name          = "${var.name}-firehose-iam-role"
  cw_metrics_stream_iam_role_name = "${var.name}-cw-metrics-stream-iam-role"
}

data "aws_iam_policy_document" "firehose_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "firehose" {
  name               = local.firehose_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.firehose_assume.json
  tags               = var.tags
}

# Kinesis stream
data "aws_iam_policy_document" "kinesis" {
  count = local.enable_kinesis ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords",
      "kinesis:ListShards"
    ]
    resources = [var.kinesis_stream_arn]
  }
}

resource "aws_iam_policy" "kinesis" {
  count  = local.enable_kinesis ? 1 : 0
  name   = "${local.firehose_iam_role_name}-kinesis"
  policy = data.aws_iam_policy_document.kinesis[0].json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "kinesis" {
  count      = local.enable_kinesis ? 1 : 0
  role       = aws_iam_role.firehose.name
  policy_arn = aws_iam_policy.kinesis[0].arn
}

# S3 bucket
data "aws_iam_policy_document" "s3" {
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3" {
  name   = "${local.firehose_iam_role_name}-s3"
  policy = data.aws_iam_policy_document.s3.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.firehose.name
  policy_arn = aws_iam_policy.s3.arn
}

# Metrics stream
data "aws_iam_policy_document" "metrics_stream_assume" {
  count = local.enable_metric_stream ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "metrics_stream" {
  count              = local.enable_metric_stream ? 1 : 0
  name               = local.cw_metrics_stream_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.metrics_stream_assume[0].json
  tags               = var.tags
}

data "aws_iam_policy_document" "metrics_stream" {
  count = local.enable_metric_stream ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [aws_kinesis_firehose_delivery_stream.this.arn]
  }
}

resource "aws_iam_policy" "metrics_stream" {
  count  = local.enable_metric_stream ? 1 : 0
  name   = "${local.cw_metrics_stream_iam_role_name}-firehose"
  policy = data.aws_iam_policy_document.metrics_stream[0].json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "metrics_stream" {
  count      = local.enable_metric_stream ? 1 : 0
  role       = aws_iam_role.metrics_stream[0].name
  policy_arn = aws_iam_policy.metrics_stream[0].arn
}
