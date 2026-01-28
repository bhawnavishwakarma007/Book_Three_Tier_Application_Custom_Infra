##################################
# AMI Inputs
##################################

variable "backend_ami_name" {
  type = string
}

variable "source_instance_id" {
  description = "Backend EC2 instance ID used to create AMI"
  type        = string
}

##################################
# Launch Template Inputs
##################################

variable "backend_launch_template_name" {
  type = string
}

variable "backend_launch_template_description" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_id" {
  description = "Backend EC2 security group ID"
  type        = string
}

##################################
# Tags
##################################

variable "backend_instance_name" {
  type = string
}
