provider "newrelic" {
  account_id = data.aws_ssm_parameter.newrelic_account_id.value
  api_key    = data.aws_ssm_parameter.newrelic_api_key.value
  region     = "US"
}
