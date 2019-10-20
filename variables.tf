#----root/variables.tf-----

variable "aws_region" {}

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

#----VPC variables----
variable "vpc_cidr" {}
variable "vpc_id" {
  default = ""
}
variable "vpc_igw_id" {
  default = ""
}
variable "vpc_route_table_id" {
  default = ""
}
variable "vpc_public_subnet_count" {}
variable "vpc_public_cidrs" {
  type = "list"
}
