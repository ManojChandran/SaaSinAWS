#----02_S3hosting/outputs.tf----

output "tf_s3_hosted_bucket" {
  value = "${aws_s3_bucket.tf_s3_host_bucket.bucket}"
}
