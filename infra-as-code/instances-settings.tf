module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 3.3.0"

  for_each = toset(["master-1", "master-2", "slave-1", "slave-2", "slave-3"])

  name = "bigdata-${each.key}"

  ami                         = "ami-0c6ebbd55ab05f070"
  instance_type               = "t2.micro"
  key_name                    = "mykey"
  monitoring                  = "true"
  vpc_security_group_ids      = ["sg-05741685675f8c261"]
  subnet_id                   = aws_subnet.big-data-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "big-data-cluster"
  }
}