##################################
# EC2 Configuration
##################################

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

##################################
# Networking Inputs
##################################

variable "subnet_id" {
  description = "Private subnet ID for backend EC2"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for backend EC2"
  type        = string
}

##################################
# Tags
##################################

variable "backend_instance_name" {
  type = string
}
