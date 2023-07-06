locals {
  enable_kinesis       = var.kinesis_stream_arn != null
  enable_metric_stream = startswith(var.type, "metrics-")
  types = {
    logs-eu : "https://aws-api.eu.newrelic.com/firehose/v1"
    logs-us : "https://aws-api.newrelic.com/firehose/v1"
    metrics-eu : "https://aws-api.eu01.nr-data.net/cloudwatch-metrics/v1"
    metrics-us : "https://aws-api.newrelic.com/cloudwatch-metrics/v1"
  }
  cw_log_group_name           = "/aws/kinesisfirehose/${var.name}"
  cw_log_delivery_stream_name = "DeliveryStream"
  cw_log_backup_stream_name   = "BackupStream"
}

resource "newrelic_api_access_key" "this" {
  account_id  = data.aws_ssm_parameter.newrelic_account_id.value
  key_type    = "INGEST"
  ingest_type = "LICENSE"
  name        = "Metric Stream Key for lite-${var.name}"
  notes       = "AWS Cloud Integrations Metric Stream Key"
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = "${var.name}-firehose"
  destination = "http_endpoint"
  tags        = var.tags

  dynamic "kinesis_source_configuration" {
    for_each = local.enable_kinesis ? [1] : []
    content {
      kinesis_stream_arn = var.kinesis_stream_arn
      role_arn           = aws_iam_role.firehose.arn
    }
  }

  http_endpoint_configuration {
    url                = local.types[var.type]
    name               = var.name
    access_key         = newrelic_api_access_key.this.key
    buffering_size     = 1
    buffering_interval = 60
    role_arn           = aws_iam_role.firehose.arn
    s3_backup_mode     = "FailedDataOnly"

    s3_configuration {
      role_arn           = aws_iam_role.firehose.arn
      bucket_arn         = aws_s3_bucket.this.arn
      buffering_size     = 10
      buffering_interval = 300
      compression_format = "GZIP"

      cloudwatch_logging_options {
        enabled         = true
        log_group_name  = aws_cloudwatch_log_group.this.name
        log_stream_name = aws_cloudwatch_log_stream.backup.name
      }
    }

    request_configuration {
      content_encoding = "GZIP"
    }

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.this.name
      log_stream_name = aws_cloudwatch_log_stream.delivery.name
    }
  }
}

resource "aws_cloudwatch_metric_stream" "this" {
  count         = local.enable_metric_stream ? 1 : 0
  name          = "${var.name}-cw-metric-stream"
  role_arn      = aws_iam_role.metrics_stream[0].arn
  firehose_arn  = aws_kinesis_firehose_delivery_stream.this.arn
  output_format = "opentelemetry0.7"
  tags          = var.tags
}
