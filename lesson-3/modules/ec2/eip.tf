resource "aws_eip" "ec2_eip" {
  domain   = "vpc"
  tags = {
    Name = "${local.username}-ec2-eip"
  }
}

resource "aws_eip_association" "eip-eni" {
  allocation_id = aws_eip.ec2_eip.id
  network_interface_id = aws_network_interface.main.id
}