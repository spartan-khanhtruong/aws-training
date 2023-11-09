resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.username}-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet" {
  count          = length(var.public_subnet_cidr_blocks)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.username}-private-route-table-${count.index + 1}"
  }
}

resource "aws_route" "private" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id         = element(aws_route_table.private.*.id, count.index )
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index )
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr_blocks)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
}