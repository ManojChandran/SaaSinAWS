#----myPublicSubnet/variables.tf----

variable "vpc_id" {}
variable "vpc_igw_id" {}
variable "vpc_public_subnet_count" {}
variable "vpc_public_cidrs" {
  type = "list"
}
