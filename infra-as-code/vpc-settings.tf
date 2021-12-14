resource "aws_subnet" "big-data-subnet" {
  vpc_id                  = "vpc-05e10346e4ba6c0ba"
  cidr_block              = "10.10.10.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "big-data-subnet"
  }
}
