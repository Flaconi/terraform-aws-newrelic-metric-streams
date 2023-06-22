terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.4"
    }

    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.25"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  required_version = ">= 1.3"
}
