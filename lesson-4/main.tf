module "main_vpc" {
  source = "./modules/vpc"

  cidr_block                 = var.cidr_block
  username                   = var.username
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id         = module.main_vpc.vpc_id
  vpc_cidr_block = var.cidr_block
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier           = "khanhtruong-lesson-4"
  engine               = "postgres"
  engine_version       = "14"
  family               = "postgres14" # DB parameter group
  major_engine_version = "14"         # DB option group
  instance_class       = "db.t3.micro"
  publicly_accessible  = false # no public IP

  db_name  = "postgres"
  username = "postgres"
  password = "postgres"
  port     = 5432

  allocated_storage = 20
  multi_az          = false

  db_subnet_group_name    = module.main_vpc.db_subnet_group
  vpc_security_group_ids  = [module.security_group.private_sg_id]
  backup_retention_period = 0

  create_db_subnet_group = true
  subnet_ids             = module.main_vpc.private_subnet_ids

  # Database Deletion Protection
  deletion_protection = false

  # max connections
  parameters = [
    {
      name         = "max_connections",
      value        = "100",
      apply_method = "pending-reboot"
    }
  ]
}