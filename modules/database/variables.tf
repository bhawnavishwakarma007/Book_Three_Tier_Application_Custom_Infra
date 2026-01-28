##################################
# Subnet Group
##################################

variable "subnet_group_name" {
  type = string
}

variable "rds_subnet_group_tag_name" {
  type = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)
}

##################################
# RDS Configuration
##################################

variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "allocated_storage" {
  type = number
}

##################################
# Backup & Maintenance
##################################

variable "backup_retention_period" {
  type = number
}

variable "backup_window" {
  type = string
}

variable "maintenance_window" {
  type = string
}

##################################
# Monitoring
##################################

variable "monitoring_interval" {
  type = number
}

variable "role_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "policy_arn" {
  type = string
}

##################################
# Networking & Protection
##################################

variable "rds_sg_id" {
  description = "RDS security group ID"
  type        = string
}

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}
