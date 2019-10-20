#----13_RDSSubnet/variables.tf----

variable "vpc_id" {}
variable "vpc_rds_subnet_count" {}
variable "vpc_rds_cidrs" {
  type = "list"
}
