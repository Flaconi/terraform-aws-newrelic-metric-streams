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

variable "attach_deny_insecure_transport_policy" {
  description = "Attach strict transport policy to S3-bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "statistics_configuration" {
  description = "For each entry in this array, you specify one or more metrics and the list of additional statistics to stream for those metrics."
  type = list(object({
    additional_statistics = list(string)
    include_metric = list(object({
      metric_name = string
      namespace   = string
    }))
  }))
  default = []
}
