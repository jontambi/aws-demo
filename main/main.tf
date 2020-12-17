module "vpc" {
  source               = "../modules/vpc"
  vpc_name             = var.vpc_name
  environment          = var.prefix
  vpc_cidr             = var.vpc_cidr
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  azs                  = var.azs
}

module "rds" {
  source = "../modules/rds"
  vpc_name             = var.vpc_name
  vpc_id               = module.vpc.vpc_id
  environment          = var.prefix
  rds_subnet1          = module.vpc.private_subnet1
  rds_subnet2          = module.vpc.private_subnet2
  db_instance          = var.db_instance
}

module "ec2" {
  source               = "../modules/ec2"
  vpc_name             = var.vpc_name
  environment          = var.prefix
#  private_subnets_cidr = var.private_subnets_cidr
  azs                  = var.azs
  subnet_id            = module.vpc.private_subnet_id
  my_public_key        = var.my_public_key

  depends_on = [ 
    module.rds
   ]
}

#module "alb" {
#  source  = "../modules/alb"
#  vpc_id  = module.vpc.id
#  subnet1 = module.vpc.subnet1
#  subnet2 = module.vpc.subnet2
  
#}