resource "aws_subnet" "public_subnets" {
  count  = length(var.public_subnet_cidr_blocks)
  vpc_id = aws_vpc.main.id

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.public_subnet_cidr_blocks[count.index]

  tags = {
    Name = "${var.username}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.main.id

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.private_subnet_cidr_blocks[count.index]

  tags = {
    Name = "${var.username}-private-subnet-${count.index + 1}"
  }
}