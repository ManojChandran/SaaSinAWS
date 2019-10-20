#----myPublicSubnet/outputs.tf----

output "vpc_public_subnets" {
  value = "${aws_subnet.tf_public_subnet.*.id}"
}
output "vpc_public_route_table" {
  value = "${aws_route_table.tf_public_rt.id}"
}
output "vpc_subnet_ips" {
  value = "${aws_subnet.tf_public_subnet.*.cidr_block}"
}
