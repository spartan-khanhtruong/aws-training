resource "aws_network_interface" "main" {
  subnet_id       = var.public_subnet_id
  security_groups = [var.public_sg_id]
}

resource "aws_network_interface_attachment" "eni_attach_ec2" {
  device_index         = 1
  instance_id          = aws_instance.main.id
  network_interface_id = aws_network_interface.main.id
}
