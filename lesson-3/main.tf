module "main_vpc" {
  source = "./modules/vpc"

  cidr_block                = local.cidr_block
  public_subnet_cidr_blocks = local.cidr_public_subnet_block
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id         = module.main_vpc.vpc_id
  vpc_cidr_block = local.cidr_block
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.main_vpc.vpc_id
  subnet_ids        = [module.main_vpc.public_subnet_id, module.main_vpc.public_subnet_id_secondary]
  security_group_id = module.security_group.public_sg_id
}


module "ec2" {
  source = "./modules/ec2"

  public_sg_id     = module.security_group.public_sg_id
  public_subnet_id = module.main_vpc.public_subnet_id
  elb_arn          = module.alb.alb_arn
  target_group_arn = module.alb.alb_target_group_arn
}
