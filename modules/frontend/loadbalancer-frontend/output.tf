output "frontend_tg_arn" {
  description = "Frontend Target Group ARN"
  value       = aws_lb_target_group.frontend_tg.arn
}

output "frontend_lb_arn" {
  description = "Frontend Load Balancer ARN"
  value       = aws_lb.frontend_lb.arn
}

output "frontend_lb_dns_name" {
  description = "Frontend ALB DNS name"
  value       = aws_lb.frontend_lb.dns_name
}
