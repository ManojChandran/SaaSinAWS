#----root/main.tf-----

provider "aws" {
  region = "${var.aws_region}"
}

# Deploy s3 hosting bucket
module "S3hosting" {
  source       = "./modules/02_S3hosting"
  website_bucket_name  = "${var.website_bucket_name}"
}
