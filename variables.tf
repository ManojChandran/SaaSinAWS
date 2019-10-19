#----root/variables.tf-----

variable "aws_region" {}

variable "domain_name" {
  default = ""
}
variable "website_bucket_name" {}

variable "api_rest_container_name" {
  default = ""
}
variable "endpoint_configuration_list" {
  default = ""
}
