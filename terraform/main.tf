# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------
terraform {
  required_version = ">=1.7.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.61.0"
    }
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------
provider "aws" {
  region = var.region
}

# ---------------------------------------------
# modules
# ---------------------------------------------

# network
module "network" {
  source = "./modules/network"

  name      = var.name
  region    = var.region
  vpc_cidr  = var.vpc_cidr
  pub_cidrs = var.public_subnet_cidrs
  pri_cidrs = var.private_subnet_cidrs
}

# ec2
module "ec2" {
  source = "./modules/ec2"

  app_name   = var.name
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.pub_subnet_ids
}

# rds
module "rds" {
  source = "./modules/rds"

  app_name                  = var.name
  db_name                   = var.db_name
  db_username               = var.db_username
  vpc_id                    = module.network.vpc_id
  subnet_ids                = module.network.pri_subnet_ids
  subnet_cidr_blocks        = module.network.pri_subnet_cidr_blocks
  source_security_group_ids = [module.ec2.ec2_security_group_id]
}

# s3
module "s3" {
  source   = "./modules/s3"
  name     = var.name
  role_arn = module.iam.role_arn
}

# IAMrole
module "iam" {
  source = "./modules/iam"
}

module "lb" {
  source = "./modules/lb"

  name        = var.name
  vpc_id      = module.network.vpc_id
  subnet_ids  = module.network.pub_subnet_ids
  instance_id = module.ec2.instance_id
}
