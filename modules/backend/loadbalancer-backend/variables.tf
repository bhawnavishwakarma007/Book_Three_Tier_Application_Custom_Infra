##################################
# Basic Inputs
##################################

variable "vpc_id" {
  type = string
}

variable "backend_tg_name" {
  type = string
}

variable "backend_lb_name" {
  type = string
}

##################################
# Networking Inputs
##################################

variable "public_subnet_ids" {
  description = "Public subnets for backend ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for backend ALB"
  type        = string
}
