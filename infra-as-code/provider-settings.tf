terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.51.0"
    }
  }
}

provider "aws" {
  region                  = "eu-west-3"
  shared_credentials_file = "/home/yacin/.aws/credentials"
}