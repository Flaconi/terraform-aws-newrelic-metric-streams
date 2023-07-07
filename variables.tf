variable "newrelic_api_key_ssm_path" {
  type        = string
  description = "flag to decide to create lambda budgets or not"
}

variable "newrelic_account_id_ssm_path" {
  type        = string
  description = "flag to decide to create lambda budgets or not"
}

variable "name" {
  type = string
}

variable "type" {
  type = string
  validation {
    error_message = "Invalid type!"
    condition     = contains(["logs-us", "logs-eu", "metrics-us", "metrics-eu"], var.type)
  }
}

variable "kinesis_stream_arn" {
  type    = string
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
