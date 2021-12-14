

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
  vpc_security_group_ids      = ["sg-0320b334b454f8ff9"]
  subnet_id                   = aws_subnet.big-data-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "big-data-cluster"
  }
}
