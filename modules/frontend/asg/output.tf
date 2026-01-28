output "frontend_asg_name" {
  value = aws_autoscaling_group.frontend_asg.name
}

output "frontend_asg_arn" {
  value = aws_autoscaling_group.frontend_asg.arn
}
