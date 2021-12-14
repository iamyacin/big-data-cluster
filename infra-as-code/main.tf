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

resource "aws_subnet" "big-data-subnet" {
  vpc_id     = "vpc-0ec182622a24f0784"
  cidr_block = "172.16.100.0/24"

  tags = {
    Name      = "big-data-subnet"
    Terraform = "true"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 3.3.0"

  for_each = toset(["master-1", "master-2", "slave-1", "slave-2", "slave-3"])

  name = "bigdata-${each.key}"

  ami                         = "ami-0df7d9cc2767d16cd"
  instance_type               = "t2.micro"
  key_name                    = "mykey"
  associate_public_ip_address = "true"
  monitoring                  = "true"
  vpc_security_group_ids      = ["sg-04e4d6d2b15206549"]
  subnet_id                   = aws_subnet.big-data-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "big-data-cluster"
  }
}