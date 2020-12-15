module "vpc" {
  source               = "../modules/vpc"
  vpc_name             = var.vpc_name
  environment          = var.prefix
  vpc_cidr             = var.vpc_cidr
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  azs                  = var.azs
}

#module "alb" {
#  source  = "../modules/alb"
#  vpc_id  = module.vpc.id
#  subnet1 = module.vpc.subnet1
#  subnet2 = module.vpc.subnet2
  
#}