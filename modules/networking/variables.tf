variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "lb_subnet_1_cidr_block" {
  description = "The CIDR block for subnet 1a"
  type        = string
}
variable "lb_subnet_2_cidr_block" {
  description = "The CIDR block for subnet 2a"
  type        = string
}

variable "frontend_subnet_3_cidr_block" {
  description = "The CIDR block for subnet 3a"
  type        = string
}
variable "frontend_subnet_4_cidr_block" {
  description = "The CIDR block for subnet 4a"
  type        = string
}

variable "backend_subnet_5_cidr_block" {
  description = "The CIDR block for subnet 5a"
  type        = string
}
variable "backend_subnet_6_cidr_block" {
  description = "The CIDR block for subnet 6a"
  type        = string
}

variable "rds_subnet_7_cidr_block" {
  description = "The CIDR block for subnet 7a"
  type        = string
}
variable "rds_subnet_8_cidr_block" {
  description = "The CIDR block for subnet 8a"
  type        = string
}

variable "lb_public_1_name" {
  description = "The name of the public subnet 1"
  type        = string
}
variable "lb_public_2_name" {
  description = "The name of the public subnet 2"
  type        = string
}
variable "frontend_private_3_name" {
  description = "The name of the frontend private subnet 3"
  type        = string
}
variable "frontend_private_4_name" {
  description = "The name of the frontend private subnet 4"
  type        = string
}
variable "backend_private_5_name" {
  description = "The name of the backend private subnet 5"
  type        = string
}
variable "backend_private_6_name" {
  description = "The name of the backend private subnet 6"
  type        = string
}
variable "rds_private_7_name" {
  description = "The name of the RDS private subnet 7"
  type        = string
}
variable "rds_private_8_name" {
  description = "The name of the RDS private subnet 8"
  type        = string
}


variable "subnet_1a_az" {
  description = "The availability zone for subnet 1b"
  type        = string
}
variable "subnet_1b_az" {
  description = "The availability zone for subnet 1b"
  type        = string
}
variable "internet_gateway_name" {
  description = "The name of the internet gateway"
  type        = string
}
variable "public_route_table_name" {
  description = "The name of the public route table"
  type        = string
}
variable "private_route_table_name" {
  description = "The name of the private route table"
  type        = string
}
variable "eip_name" {
  description = "The name of the EIP"
  type        = string
}
variable "nat_gateway_name" {
  description = "The name of the NAT gateway"
  type        = string
}

##################################
# Security Group Names
##################################

variable "bastion_host_sg_name" {
  description = "Security Group name for Bastion host"
  type        = string
}

variable "alb_frontend_sg_name" {
  description = "Security Group name for Frontend ALB"
  type        = string
}

variable "alb_backend_sg_name" {
  description = "Security Group name for Backend ALB"
  type        = string
}

variable "frontend_server_sg_name" {
  description = "Security Group name for Frontend EC2 servers"
  type        = string
}

variable "backend_server_sg_name" {
  description = "Security Group name for Backend EC2 servers"
  type        = string
}

variable "rds_sg_name" {
  description = "Security Group name for RDS database"
  type        = string
}
