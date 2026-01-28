##################################
# Frontend AMI Creation
##################################

resource "aws_ami_from_instance" "frontend_ami" {
  name                    = var.frontend_ami_name
  source_instance_id      = var.source_instance_id
  snapshot_without_reboot = false

  tags = {
    Name = var.frontend_ami_name
  }
}

##################################
# Frontend Launch Template
##################################

resource "aws_launch_template" "frontend" {
  name                   = var.frontend_launch_template_name
  description            = var.frontend_launch_template_description
  image_id               = aws_ami_from_instance.frontend_ami.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.frontend_instance_name
    }
  }
}
