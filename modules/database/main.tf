##################################
# RDS Subnet Group
##################################

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.rds_subnet_group_tag_name
  }
}

##################################
# IAM Role for RDS Enhanced Monitoring
##################################

resource "aws_iam_role" "rds_iam_role" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_iam_role.name
  policy_arn = var.policy_arn
}

##################################
# RDS Instance
##################################

resource "aws_db_instance" "rds" {
  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class

  username             = var.username
  password             = var.password
  allocated_storage    = var.allocated_storage

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  monitoring_interval     = var.monitoring_interval
  monitoring_role_arn     = aws_iam_role.rds_iam_role.arn

  maintenance_window      = var.maintenance_window
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
}
