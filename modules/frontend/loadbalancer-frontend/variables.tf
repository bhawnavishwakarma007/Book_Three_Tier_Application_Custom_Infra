##################################
# Basic Inputs
##################################

variable "vpc_id" {
  type = string
}

variable "frontend_tg_name" {
  type = string
}

variable "frontend_lb_name" {
  type = string
}

##################################
# Networking Inputs
##################################

variable "public_subnet_ids" {
  description = "Public subnets for frontend ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for frontend ALB"
  type        = string
}
