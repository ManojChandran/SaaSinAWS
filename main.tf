#----root/main.tf-----

provider "aws" {
  region = "${var.aws_region}"
}

# Deploy s3 hosting bucket
module "S3hosting" {
  source       = "./modules/02_S3hosting"
  website_bucket_name  = "${var.website_bucket_name}"
}

# Deploy cloudformation distribution
module "Cldfrntdistro" {
  source       = "./modules/03_Cldfrontdistro"
  domain_name  = "${var.domain_name}"
  hosted_website_bucket_name  = "${module.S3hosting.tf_s3_hosted_bucket}"
}

# Deploy API gateway
module "Apigateway" {
  source       = "./modules/04_ApiGateway"
  api_rest_container_name = "${var.website_bucket_name}-rest-api"
}
