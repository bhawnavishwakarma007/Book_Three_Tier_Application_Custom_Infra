output "backend_tg_arn" {
  description = "Backend Target Group ARN"
  value       = aws_lb_target_group.backend_tg.arn
}

output "backend_lb_arn" {
  description = "Backend Load Balancer ARN"
  value       = aws_lb.backend_lb.arn
}

output "backend_lb_dns_name" {
  description = "Backend ALB DNS name"
  value       = aws_lb.backend_lb.dns_name
}
