terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

resource "aws_vpc" "my-principal-vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "big-data-vpc"
  }
}

resource "aws_subnet" "big-data-subnet" {
  vpc_id     = aws_vpc.my-principal-vpc.id
  cidr_block = "172.16.100.0/24"

  tags = {
    Name = "big-data-subnet"
  }
}