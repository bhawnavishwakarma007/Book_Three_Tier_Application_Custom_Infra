##################################
# NETWORKING (VPC + SUBNETS + SG)
##################################

module "networking" {
  source = "../../modules/networking"

  vpc_cidr_block = "10.0.0.0/16"
  vpc_name       = "book_t3_vpc"

  subnet_1a_az = "us-east-1a"
  subnet_1b_az = "us-east-1b"

  lb_subnet_1_cidr_block = "10.0.1.0/24"
  lb_subnet_2_cidr_block = "10.0.2.0/24"

  frontend_subnet_3_cidr_block = "10.0.3.0/24"
  frontend_subnet_4_cidr_block = "10.0.4.0/24"

  backend_subnet_5_cidr_block = "10.0.5.0/24"
  backend_subnet_6_cidr_block = "10.0.6.0/24"

  rds_subnet_7_cidr_block = "10.0.7.0/24"
  rds_subnet_8_cidr_block = "10.0.8.0/24"

  lb_public_1_name        = "book_t3_lb_public_1"
  lb_public_2_name        = "book_t3_lb_public_2"
  frontend_private_3_name = "book_t3_frontend_private_1"
  frontend_private_4_name = "book_t3_frontend_private_2"
  backend_private_5_name  = "book_t3_backend_private_1"
  backend_private_6_name  = "book_t3_backend_private_2"
  rds_private_7_name      = "book_t3_rds_private_1"
  rds_private_8_name      = "book_t3_rds_private_2"

  internet_gateway_name    = "book_t3_igw"
  public_route_table_name  = "book_t3_public_rt"
  private_route_table_name = "book_t3_private_rt"
  eip_name                 = "book_t3_eip"
  nat_gateway_name         = "book_t3_nat"

  bastion_host_sg_name    = "book_t3_bastion_sg"
  alb_frontend_sg_name    = "book_t3_frontend_alb_sg"
  alb_backend_sg_name     = "book_t3_backend_alb_sg"
  frontend_server_sg_name = "book_t3_frontend_ec2_sg"
  backend_server_sg_name  = "book_t3_backend_ec2_sg"
  rds_sg_name             = "book_t3_rds_sg"
}

##################################
# BASTION HOST
##################################

module "bastion" {
  source = "../../modules/bation"

  ami               = "ami-00ca32bbc84273381"
  instance_type     = "t2.micro"
  key_name          = "us-east-1"
  subnet_id         = module.networking.lb_public_subnet_ids[0]
  security_group_id = module.networking.bastion_sg_id
}

##################################
# BACKEND EC2 (AMI BUILDER)
##################################

module "backend_ec2" {
  source = "../../modules/backend/ec2"

  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  key_name      = "us-east-1"

  subnet_id         = module.networking.lb_public_subnet_ids[0]
  security_group_id = module.networking.backend_sg_id

  backend_instance_name = "book_t3_backend_ec2"
}

##################################
# FRONTEND EC2 (AMI BUILDER)
##################################

module "frontend_ec2" {
  source = "../../modules/frontend/ec2"

  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  key_name      = "us-east-1"

  subnet_id         = module.networking.lb_public_subnet_ids[0]
  security_group_id = module.networking.frontend_sg_id

  frontend_instance_name = "book_t3_frontend_ec2"
}

##################################
# RDS
##################################

module "database" {
  source = "../../modules/database"

  subnet_group_name         = "book_t3_rds_subnet_group"
  rds_subnet_group_tag_name = "book_t3_rds"

  subnet_ids = module.networking.rds_private_subnet_ids
  rds_sg_id  = module.networking.rds_sg_id

  identifier        = "book-t3-rds"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = "SuperSecretPass123"
  allocated_storage = 20

  backup_retention_period = 7
  backup_window           = "07:00-09:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  monitoring_interval = 60
  role_name           = "book_t3_rds_monitoring_role"
  assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "monitoring.rds.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"

  deletion_protection = true
  skip_final_snapshot = false
}

##################################
# BACKEND LAUNCH TEMPLATE (AMI + LT)
##################################

module "backend_launch_template" {
  source = "../../modules/backend/launch-template"

  backend_ami_name    = "book_t3_backend_ami"
  source_instance_id = module.backend_ec2.backend_instance_id

  backend_launch_template_name        = "book_t3_backend_lt"
  backend_launch_template_description = "Launch template for backend ASG"

  instance_type     = "t2.micro"
  key_name          = "us-east-1"
  security_group_id = module.networking.backend_sg_id

  backend_instance_name = "book_t3_backend"
}

##################################
# FRONTEND LAUNCH TEMPLATE (AMI + LT)
##################################

module "frontend_launch_template" {
  source = "../../modules/frontend/launch-template"

  frontend_ami_name   = "book_t3_frontend_ami"
  source_instance_id = module.frontend_ec2.frontend_instance_id

  frontend_launch_template_name        = "book_t3_frontend_lt"
  frontend_launch_template_description = "Launch template for frontend ASG"

  instance_type     = "t2.micro"
  key_name          = "us-east-1"
  security_group_id = module.networking.frontend_sg_id

  frontend_instance_name = "book_t3_frontend"
}

##################################
# BACKEND LOAD BALANCER
##################################

module "backend_alb" {
  source = "../../modules/backend/loadbalancer-backend"

  vpc_id                = module.networking.vpc_id
  backend_tg_name       = "book-t3-backend-tg"
  backend_lb_name       = "book-t3-backend-alb"
  public_subnet_ids     = module.networking.lb_public_subnet_ids
  alb_security_group_id = module.networking.alb_backend_sg_id
}

##################################
# FRONTEND LOAD BALANCER
##################################

module "frontend_alb" {
  source = "../../modules/frontend/loadbalancer-frontend"

  vpc_id                = module.networking.vpc_id
  frontend_tg_name      = "book-t3-frontend-tg"
  frontend_lb_name      = "book-t3-frontend-alb"
  public_subnet_ids     = module.networking.lb_public_subnet_ids
  alb_security_group_id = module.networking.alb_frontend_sg_id
}

##################################
# BACKEND ASG
##################################

module "backend_asg" {
  source = "../../modules/backend/asg"

  backend_asg_name              = "book_t3_backend_asg"
  backend_scale_out_policy_name = "book_t3_backend_scale_out"

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  launch_template_id = module.backend_launch_template.backend_launch_template_id
  private_subnet_ids = module.networking.backend_private_subnet_ids
  target_group_arn   = module.backend_alb.backend_tg_arn
}

##################################
# FRONTEND ASG
##################################

module "frontend_asg" {
  source = "../../modules/frontend/asg"

  frontend_asg_name              = "book_t3_frontend_asg"
  frontend_scale_out_policy_name = "book_t3_frontend_scale_out"

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  launch_template_id = module.frontend_launch_template.frontend_launch_template_id
  private_subnet_ids = module.networking.frontend_private_subnet_ids
  target_group_arn   = module.frontend_alb.frontend_tg_arn
}
