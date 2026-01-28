##################################
# Bastion Host Security Group
##################################

resource "aws_security_group" "bastion_host_sg" {
  name        = var.bastion_host_sg_name
  description = "Allow SSH access"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.bastion_host_sg_name
  }
}

##################################
# Frontend ALB Security Group
##################################

resource "aws_security_group" "alb_frontend_sg" {
  name        = var.alb_frontend_sg_name
  description = "Allow inbound traffic to frontend ALB"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.alb_frontend_sg_name
  }
}

##################################
# Backend ALB Security Group
##################################

resource "aws_security_group" "alb_backend_sg" {
  name        = var.alb_backend_sg_name
  description = "Allow inbound traffic to backend ALB"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.alb_backend_sg_name
  }
}

##################################
# Frontend EC2 Security Group
##################################

resource "aws_security_group" "frontend_server_sg" {
  name        = var.frontend_server_sg_name
  description = "Allow inbound traffic to frontend servers"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = [22, 80]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.frontend_server_sg_name
  }
}

##################################
# Backend EC2 Security Group
##################################

resource "aws_security_group" "backend_server_sg" {
  name        = var.backend_server_sg_name
  description = "Allow inbound traffic to backend servers"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = [22, 80]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.backend_server_sg_name
  }
}

##################################
# RDS Security Group
##################################

resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = "Allow MySQL access"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}
