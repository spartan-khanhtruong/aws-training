output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_id_secondary" {
  value = aws_subnet.public_subnet_2.id
}