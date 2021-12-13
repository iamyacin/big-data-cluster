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

resource "aws_budgets_budget" "budget-limit" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "5.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2020-12-12_00:05"
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

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 3.3.0"

  for_each = toset(["master-1", "master-2", "slave-1", "slave-2", "slave-3"])

  name = "bigdata-${each.key}"

  ami                    = "ami-0df7d9cc2767d16cd"
  instance_type          = "t2.micro"
  key_name               = "mykey"
  monitoring             = true
  vpc_security_group_ids = ["sg-0320b334b454f8ff9"]
  subnet_id              = aws_subnet.big-data-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "big-data-cluster"
  }
}