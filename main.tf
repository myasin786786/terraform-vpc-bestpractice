# ---- Initilizing VPC Module ---- #

module "vpc" {
  source                      = "./modules/vpc"
  vpc_cidr                    = var.vpc_cidr
  number_of_public_subnets    = var.number_of_public_subnets
  number_of_private_subnets   = var.number_of_private_subnets
  project_tags                = var.project_tags
}