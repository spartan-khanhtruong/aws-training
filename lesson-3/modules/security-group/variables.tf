variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The VPC CIDR block"
}

variable "public_port" {
  type = list(number)
  description = "The public port"
  default = [80, 443, 22, ]
}
