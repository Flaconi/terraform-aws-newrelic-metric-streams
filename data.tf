data "aws_ssm_parameter" "newrelic_account_id" {
  name = var.newrelic_account_id_ssm_path
}

data "aws_ssm_parameter" "newrelic_api_key" {
  name = var.newrelic_api_key_ssm_path
}
