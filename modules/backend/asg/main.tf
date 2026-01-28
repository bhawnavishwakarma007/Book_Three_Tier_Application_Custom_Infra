##################################
# Backend Auto Scaling Group
##################################

resource "aws_autoscaling_group" "backend_asg" {
  name             = var.backend_asg_name
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = var.private_subnet_ids

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "Name"
    value               = var.backend_asg_name
    propagate_at_launch = true
  }
}

##################################
# Backend Scale-Out Policy
##################################

resource "aws_autoscaling_policy" "backend_scale_out" {
  name                   = var.backend_scale_out_policy_name
  autoscaling_group_name = aws_autoscaling_group.backend_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.scale_out_target_value
  }
}
