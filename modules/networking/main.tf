##################################
# VPC
##################################

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

##################################
# PUBLIC SUBNETS (ALB)
##################################

resource "aws_subnet" "lb_public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.lb_subnet_1_cidr_block
  availability_zone       = var.subnet_1a_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.lb_public_1_name
  }
}

resource "aws_subnet" "lb_public_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.lb_subnet_2_cidr_block
  availability_zone       = var.subnet_1b_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.lb_public_2_name
  }
}

##################################
# FRONTEND PRIVATE SUBNETS
##################################

resource "aws_subnet" "frontend_private_3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.frontend_subnet_3_cidr_block
  availability_zone = var.subnet_1a_az

  tags = {
    Name = var.frontend_private_3_name
  }
}

resource "aws_subnet" "frontend_private_4" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.frontend_subnet_4_cidr_block
  availability_zone = var.subnet_1b_az

  tags = {
    Name = var.frontend_private_4_name
  }
}

##################################
# BACKEND PRIVATE SUBNETS
##################################

resource "aws_subnet" "backend_private_5" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.backend_subnet_5_cidr_block
  availability_zone = var.subnet_1a_az

  tags = {
    Name = var.backend_private_5_name
  }
}

resource "aws_subnet" "backend_private_6" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.backend_subnet_6_cidr_block
  availability_zone = var.subnet_1b_az

  tags = {
    Name = var.backend_private_6_name
  }
}

##################################
# RDS PRIVATE SUBNETS
##################################

resource "aws_subnet" "rds_private_7" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.rds_subnet_7_cidr_block
  availability_zone = var.subnet_1a_az

  tags = {
    Name = var.rds_private_7_name
  }
}

resource "aws_subnet" "rds_private_8" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.rds_subnet_8_cidr_block
  availability_zone = var.subnet_1b_az

  tags = {
    Name = var.rds_private_8_name
  }
}

##################################
# INTERNET GATEWAY
##################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

##################################
# PUBLIC ROUTE TABLE
##################################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public_1" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.lb_public_1.id
}

resource "aws_route_table_association" "public_2" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.lb_public_2.id
}

##################################
# NAT GATEWAY
##################################

resource "aws_eip" "nat_eip" {
  tags = {
    Name = var.eip_name
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.lb_public_1.id

  tags = {
    Name = var.nat_gateway_name
  }
}

##################################
# PRIVATE ROUTE TABLE
##################################

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_frontend_3" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.frontend_private_3.id
}

resource "aws_route_table_association" "private_frontend_4" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.frontend_private_4.id
}

resource "aws_route_table_association" "private_backend_5" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.backend_private_5.id
}

resource "aws_route_table_association" "private_backend_6" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.backend_private_6.id
}

resource "aws_route_table_association" "private_rds_7" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.rds_private_7.id
}

resource "aws_route_table_association" "private_rds_8" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.rds_private_8.id
}
