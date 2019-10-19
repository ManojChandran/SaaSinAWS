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
  hosted_website_bucket_name  = "${module.mys3hosting.tf_s3_hosted_bucket}"
}
