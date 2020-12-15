terraform {
  required_version = ">= 0.12.28"

  required_providers {
    aws = ">= 2.8"
  }
}

provider "random" {
  version = "~> 2.1"
}
