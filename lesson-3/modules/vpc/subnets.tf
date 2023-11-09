resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-southeast-2a"
  cidr_block        = var.public_subnet_cidr_blocks[0]

  tags = {
    Name = "${local.username}-public-subnet"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-southeast-2b"
  cidr_block        = var.public_subnet_cidr_blocks[1]

  tags = {
    Name = "${local.username}-public-subnet"
  }
}