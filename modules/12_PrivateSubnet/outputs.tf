#----myPrivateSubnet/outputs.tf----

output "vpc_private_subnets" {
  value = "${aws_subnet.tf_private_subnet.*.id}"
}
#output "vpc_private_route_table" {
#  value = "${aws_route_table.tf_private_rt.id}"
#}
