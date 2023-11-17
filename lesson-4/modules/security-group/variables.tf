variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_port" {
  type        = list(number)
  description = "Public port"
  default     = [80, 443]
}

variable "private_port" {
  type        = list(number)
  description = "Private port"
  default     = [5432, 22]
}