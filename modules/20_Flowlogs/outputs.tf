#----20_Flowlogs/outputs.tf----

output "tf_s3_flowlogs_bucket" {
  value = "${aws_s3_bucket.tf_flowlogs_bucket.bucket}"
}
