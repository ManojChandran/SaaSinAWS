#----20_Flowlogs/outputs.tf----

output "tf_VPC_flowlogs_id" {
  value = "${aws_s3_bucket.tf_vpc_flowlogs.id}"
}
