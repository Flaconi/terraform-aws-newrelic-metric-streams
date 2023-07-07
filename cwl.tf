resource "aws_cloudwatch_log_group" "this" {
  name              = local.cw_log_group_name
  retention_in_days = 7
  tags              = var.tags
}

resource "aws_cloudwatch_log_stream" "delivery" {
  name           = local.cw_log_delivery_stream_name
  log_group_name = aws_cloudwatch_log_group.this.name
}

resource "aws_cloudwatch_log_stream" "backup" {
  name           = local.cw_log_backup_stream_name
  log_group_name = aws_cloudwatch_log_group.this.name
}
