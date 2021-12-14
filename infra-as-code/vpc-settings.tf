resource "aws_vpc" "my-principal-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "big-data-vpc"
  }
}

resource "aws_network_acl" "my-nacl" {
  vpc_id = aws_vpc.my-principal-vpc.id 

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "my-nacl"
  }
}

resource "aws_internet_gateway" "my-internet-gw" {
  vpc_id = aws_vpc.my-principal-vpc.id

  tags = {
    Name = "my-internet-gw"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-principal-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-internet-gw.id
  }

  tags = {
    Name = "my-rt"
  }
}

resource "aws_subnet" "big-data-subnet" {
  vpc_id                  = aws_vpc.my-principal-vpc.id
  cidr_block              = "172.16.100.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "big-data-subnet"
  }
}

resource "aws_route_table_association" "rt-to-subnet" {
  subnet_id      = aws_subnet.big-data-subnet.id
  route_table_id = aws_route_table.my-rt.id
}
