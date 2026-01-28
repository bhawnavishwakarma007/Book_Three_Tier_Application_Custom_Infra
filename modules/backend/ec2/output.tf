output "backend_instance_id" {
  value = aws_instance.backend_server.id
}

output "backend_private_ip" {
  value = aws_instance.backend_server.private_ip
}
