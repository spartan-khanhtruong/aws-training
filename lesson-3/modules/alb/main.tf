resource "aws_lb" "main" {
  name                       = "khanh-truong-lb"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = [var.security_group_id]
  subnets                    = var.subnet_ids
  idle_timeout               = var.ide_timeout
  enable_deletion_protection = false

}


resource "aws_alb_target_group" "target_group" {
  name     = "khanh-truong-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = 80
    protocol = "HTTP"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.main.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}