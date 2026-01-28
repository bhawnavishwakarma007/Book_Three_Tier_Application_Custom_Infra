##################################
# Backend EC2 Instance
##################################

resource "aws_instance" "backend_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y

              # Install required packages
              yum install -y python3 python3-pip git mariadb105

              # Clone Paytm backend
              cd /opt
              git clone https://github.com/CloudTechDevOps/Paytm-fullstack-project.git

              # Install backend dependencies
              cd Paytm-fullstack-project/Backend
              pip3 install -r requirements.txt

              # Start backend service
              nohup python3 rds.py > /var/log/backend.log 2>&1 &
              EOF

  tags = {
    Name = var.backend_instance_name
  }
}
