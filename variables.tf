#----root/variables.tf-----

variable "aws_region" {}

vpc_cidr  = "10.23.0.0/16"
variable "tenantTier" {
  description = "tenantTier: Tenant1 or Tenant2 or Tenant3 or Tenant4"
}

variable "domain_name" {
  default = ""
}
variable "website_bucket_name" {}

variable "api_rest_container_name" {
  default = ""
}

variable "vpc_cidr" {}
