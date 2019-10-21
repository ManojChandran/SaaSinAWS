#----20_Flowlogs/outputs.tf----

output "tf_VPC_flowlogs_id" {
  value = "${aws_flow_log.tf_vpc_flowlogs.id}"
}
