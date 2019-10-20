#----root/main.tf-----

provider "aws" {
  region = "${var.aws_region}"
}
#========commenting below for testing
## Deploy s3 hosting bucket
#module "S3hosting" {
#  source       = "./modules/02_S3hosting"
#  website_bucket_name  = "${var.website_bucket_name}"
#}
#
## Deploy cloudformation distribution
#module "Cldfrntdistro" {
#  source       = "./modules/03_Cldfrontdistro"
#  domain_name  = "${var.domain_name}"
#  hosted_website_bucket_name  = "${module.S3hosting.tf_s3_hosted_bucket}"
#}
#
## Deploy API gateway
#module "Apigateway" {
#  source       = "./modules/04_ApiGateway"
#  api_rest_container_name = "${var.website_bucket_name}-rest-api"
#}
#========commenting above for testing
# Deploy VPC and attach IGW
module "vpc_igw" {
  source       = "./modules/10_VPC_igw"
  vpc_cidr     = "${var.vpc_cidr}"
}

# Deploy Public Subnet and Route tables
module "PublicSubnet" {
  source       = "./modules/11_PublicSubnet"
  vpc_id       = "${module.vpc_igw.vpc_id}"
  vpc_igw_id   = "${module.vpc_igw.igw_id}"
#  vpc_route_table_id      = "${module.vpc_igw.default_route_table_id}"
  vpc_public_subnet_count = "${var.vpc_public_subnet_count}"
  vpc_public_cidrs        = "${var.vpc_public_cidrs}"
}

# Deploy Private Subnet and Route tables
module "PrivateSubnet" {
  source       = "./modules/12_PrivateSubnet"
  vpc_id       = "${module.vpc_igw.vpc_id}"
#  vpc_igw_id   = "${module.vpc_igw.igw_id}"
  vpc_route_table_id       = "${module.vpc_igw.default_route_table_id}"
  vpc_private_subnet_count = "${var.vpc_private_subnet_count}"
  vpc_private_cidrs        = "${var.vpc_private_cidrs}"
}

# Deploy RDS Subnet and Route tables
module "RDSSubnet" {
  source       = "./modules/13_RDSSubnet"
  vpc_id       = "${module.vpc_igw.vpc_id}"
  vpc_rds_subnet_count = "${var.vpc_rds_subnet_count}"
  vpc_rds_cidrs        = "${var.vpc_rds_cidrs}"
}
