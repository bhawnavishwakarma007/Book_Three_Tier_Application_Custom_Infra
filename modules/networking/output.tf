output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "lb_public_subnet_ids" {
  value = [
    aws_subnet.lb_public_1.id,
    aws_subnet.lb_public_2.id
  ]
}

output "frontend_private_subnet_ids" {
  value = [
    aws_subnet.frontend_private_3.id,
    aws_subnet.frontend_private_4.id
  ]
}

output "backend_private_subnet_ids" {
  value = [
    aws_subnet.backend_private_5.id,
    aws_subnet.backend_private_6.id
  ]
}

output "rds_private_subnet_ids" {
  value = [
    aws_subnet.rds_private_7.id,
    aws_subnet.rds_private_8.id
  ]
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_host_sg.id
}

output "alb_frontend_sg_id" {
  value = aws_security_group.alb_frontend_sg.id
}

output "alb_backend_sg_id" {
  value = aws_security_group.alb_backend_sg.id
}

output "frontend_sg_id" {
  value = aws_security_group.frontend_server_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_server_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
