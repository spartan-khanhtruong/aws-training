resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${local.username}-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_1.id
}