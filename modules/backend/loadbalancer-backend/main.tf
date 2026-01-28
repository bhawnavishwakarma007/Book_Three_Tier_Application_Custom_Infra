##################################
# Backend Target Group
##################################

resource "aws_lb_target_group" "backend_tg" {
  name     = var.backend_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

#   health_check {
#     protocol            = "HTTP"
#     port                = "80"
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }
}

##################################
# Backend Application Load Balancer
##################################

resource "aws_lb" "backend_lb" {
  name               = var.backend_lb_name
  load_balancer_type = "application"
  internal           = false

  subnets         = var.public_subnet_ids
  security_groups = [var.alb_security_group_id]

  tags = {
    Name = var.backend_lb_name
  }
}

##################################
# Backend Listener
##################################

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}
