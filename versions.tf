terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.53"
    }

    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.22.0"
    }
  }
  required_version = ">= 1.3"
}
