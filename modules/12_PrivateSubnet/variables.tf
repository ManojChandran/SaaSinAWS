#----myPrivateSubnet/variables.tf----

variable "vpc_id" {}
#variable "vpc_igw_id" {}
variable "vpc_private_subnet_count" {}
variable "vpc_route_table_id" {}
variable "vpc_private_cidrs" {
  type = "list"
}
