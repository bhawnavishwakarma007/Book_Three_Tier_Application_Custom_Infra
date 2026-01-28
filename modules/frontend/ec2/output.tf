output "frontend_instance_id" {
  value = aws_instance.frontend_server.id
}

output "frontend_private_ip" {
  value = aws_instance.frontend_server.private_ip
}
