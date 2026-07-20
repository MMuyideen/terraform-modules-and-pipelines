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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2_sg" {
  source = "../../modules/aws/security-group"

  name        = "${var.project_name}-ec2-sg"
  description = "Security group for ${var.project_name} EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = var.ingress_rules

  egress_rules = var.egress_rules
}

module "ec2" {
  source = "../../modules/aws/ec2"

  name                        = "${var.project_name}-instance"
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnet_ids[0]
  security_group_ids          = [module.ec2_sg.id]
  associate_public_ip_address = true
  tags                        = var.tags
}
