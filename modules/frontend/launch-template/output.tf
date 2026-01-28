output "frontend_ami_id" {
  description = "Frontend AMI ID"
  value       = aws_ami_from_instance.frontend_ami.id
}

output "frontend_launch_template_id" {
  description = "Frontend Launch Template ID"
  value       = aws_launch_template.frontend.id
}

output "frontend_launch_template_latest_version" {
  value = aws_launch_template.frontend.latest_version
}
