resource "aws_instance" "main" {
  ami                         = "ami-07b5c2e394fccab6e"
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name = "${local.username}-ec2-instance"
  }

}