variable "backend_asg_name" {
  type = string
}

variable "backend_scale_out_policy_name" {
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

variable "launch_template_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "scale_out_target_value" {
  type    = number
  default = 80
}
