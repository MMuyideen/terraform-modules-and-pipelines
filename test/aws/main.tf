module "vpc" {
  source = "../../modules/aws/vpc"

  cidr_block           = var.vpc_cidr_block
  project_name         = var.project_name
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  tags                 = var.tags
}
