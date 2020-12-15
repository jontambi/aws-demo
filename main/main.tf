module "vpc" {
  source       = "../modules/vpc"
  vpc_name     = var.vpc_name
  environment  = var.prefix
  vpc_cidr     = var.vpc_cidr
  subnets_cidr = var.subnets_cidr
  azs          = var.azs
}