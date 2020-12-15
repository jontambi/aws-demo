module "vpc" {
  source               = "../modules/vpc"
  vpc_name             = var.vpc_name
  environment          = var.prefix
  vpc_cidr             = var.vpc_cidr
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  azs                  = var.azs
}