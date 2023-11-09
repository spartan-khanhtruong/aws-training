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