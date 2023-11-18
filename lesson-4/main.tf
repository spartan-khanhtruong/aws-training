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

module "ec2" {
  source = "./modules/ec2"

  public_sg_id     = module.security_group.public_sg_id
  public_subnet_id = module.main_vpc.public_subnet_ids[0]

  db_host     = module.db.db_instance_address
  db_port     = local.db_port
  db_name     = local.db_name
  db_username = local.db_username
  db_password = local.db_password

  depends_on = [module.db]
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier                  = "khanhtruong-lesson-4"
  engine                      = "postgres"
  engine_version              = "14"
  family                      = "postgres14" # DB parameter group
  major_engine_version        = "14"         # DB option group
  instance_class              = "db.t3.micro"
  publicly_accessible         = false # no public IP

  manage_master_user_password = false

  db_name                     = local.db_name
  username                    = local.db_username
  password                    = local.db_password
  port                        = local.db_port

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