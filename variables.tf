variable "newrelic_api_key_ssm_path" {
  type        = string
  description = "flag to decide to create lambda budgets or not"
}

variable "newrelic_account_id_ssm_path" {
  type        = string
  description = "flag to decide to create lambda budgets or not"
}

variable "newrelic_account_region" {
  type    = string
  default = "US"
}

variable "name" {
  type = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
