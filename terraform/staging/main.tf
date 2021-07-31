module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source              = "../modules/instances"
  ENV                 = var.ENV
  VPC_ID              = module.main-vpc.vpc_id
  PUBLIC_SUBNETS      = module.main-vpc.public_subnets
  PATH_TO_PUBLIC_KEY  = "prostylee-${var.ENV}.pub"
}

module "rds" {
  source              = "../modules/rds"
  ENV                 = var.ENV
  PUBLIC_SUBNETS      = module.main-vpc.public_subnets
  DB_PASSWORD         = var.DB_PASSWORD
  VPC_ID              = module.main-vpc.vpc_id
}

module "eip" {
  source              = "../modules/eip"
  ENV                 = var.ENV
  INSTANCE_ID         = module.instances.instance_id
}

module "cloudformation" {
  source              = "../modules/cloudformation"
  ENV                 = var.ENV
  S3_BUCKET_NAME      = var.S3_BUCKET_NAME_FOR_IMAGES
}