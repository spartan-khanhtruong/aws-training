resource "aws_eip" "nat" {
  count  = length(var.public_subnet_cidr_blocks)
  domain = "vpc"

  tags = {
    Name = "${var.username}-nat-eip-${count.index}"
  }
}

resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnet_cidr_blocks)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  depends_on = [
    aws_internet_gateway.main
  ]

  tags = {
    Name = "${var.username}-nat-gateway-${count.index}"
  }
}