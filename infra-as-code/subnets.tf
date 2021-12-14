resource "aws_subnet" "big-data-subnet" {
  vpc_id                  = aws_vpc.my-principal-vpc.id
  cidr_block              = "172.16.100.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "big-data-subnet"
  }
}