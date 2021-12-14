resource "aws_internet_gateway" "my-internet-gw" {
  vpc_id = aws_vpc.my-principal-vpc.id

  tags = {
    Name = "my-internet-gw"
  }
}