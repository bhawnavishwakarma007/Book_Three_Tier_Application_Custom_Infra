##################################
# ASG Basics
##################################

variable "frontend_asg_name" {
  type = string
}

variable "frontend_scale_out_policy_name" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

##################################
# Inputs from other modules
##################################

variable "launch_template_id" {
  description = "Frontend Launch Template ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Frontend private subnet IDs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Frontend Target Group ARN"
  type        = string
}

##################################
# Scaling
##################################

variable "scale_out_target_value" {
  type    = number
  default = 80
}
