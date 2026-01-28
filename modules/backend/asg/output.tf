output "backend_asg_name" {
  value = aws_autoscaling_group.backend_asg.name
}

output "backend_asg_arn" {
  value = aws_autoscaling_group.backend_asg.arn
}
