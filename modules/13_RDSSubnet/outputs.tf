#----13_RDSSubnet/outputs.tf----

output "vpc_RDS_subnets" {
  value = "${aws_subnet.tf_RDS_subnet.*.id}"
}
#output "vpc_RDS_subnetsgroup" {
#  value = "${aws_db_subnet_group.tf_rds_subnetgroup.name}"
#}
