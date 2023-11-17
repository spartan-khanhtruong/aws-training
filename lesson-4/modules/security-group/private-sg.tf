resource "aws_security_group" "private" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.private_port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr_block]
    }
  }

  tags = {
    Name = "private-sg"
  }
}