variable "cidr_block" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "your aws public subnet cidr blocks. eg: [10.105.1.0/24]"
}