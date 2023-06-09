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

    random = {
      source = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
  required_version = ">= 1.3"
}
