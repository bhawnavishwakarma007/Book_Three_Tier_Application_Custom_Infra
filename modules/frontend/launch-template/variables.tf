##################################
# AMI Inputs
##################################

variable "frontend_ami_name" {
  type = string
}

variable "source_instance_id" {
  description = "Frontend EC2 instance ID used to create AMI"
  type        = string
}

##################################
# Launch Template Inputs
##################################

variable "frontend_launch_template_name" {
  type = string
}

variable "frontend_launch_template_description" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_id" {
  description = "Frontend EC2 security group ID"
  type        = string
}

##################################
# Tags
##################################

variable "frontend_instance_name" {
  type = string
}
