variable "username" {
  type        = string
  description = "your aws name"
}

variable "cidr_block" {
  type        = string
  default     = "10.105.0.0/16"
  description = "your aws cidr block. eg: 10.105.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "your aws public subnet cidr blocks. eg: [10.105.1.0/24]"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "your aws private subnet cidr blocks. eg: [10.105.2.0/24]"
}