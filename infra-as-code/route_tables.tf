resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-principal-vpc.id

  route {
    cidr_block = "172.16.0.0/16"
  }

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-internet-gw.id
  }

  tags = {
    Name = "example"
  }
}