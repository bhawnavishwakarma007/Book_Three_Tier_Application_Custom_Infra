output "backend_ami_id" {
  description = "Backend AMI ID"
  value       = aws_ami_from_instance.backend_ami.id
}

output "backend_launch_template_id" {
  description = "Backend Launch Template ID"
  value       = aws_launch_template.backend.id
}

output "backend_launch_template_latest_version" {
  description = "Latest version of backend launch template"
  value       = aws_launch_template.backend.latest_version
}
