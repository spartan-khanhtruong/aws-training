resource "aws_launch_configuration" "auto_scaling_config" {
  image_id                    = "ami-07b5c2e394fccab6e"
  instance_type               = "t2.micro"
  user_data                   = file("${path.module}/user_data.sh")
  security_groups             = [var.public_sg_id]
  associate_public_ip_address = true // for bootstrapping the instance
  // create custom AMI to avoid assign public IP address

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "auto_scaling" {
  launch_configuration = aws_launch_configuration.auto_scaling_config.name

  max_size         = 3
  min_size         = 1
  desired_capacity = 2

  vpc_zone_identifier = [var.public_subnet_id]

  target_group_arns = [var.target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true
}