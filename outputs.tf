#----root/outputs.tf-----

output "S3 Hosted bucket name" {
  value = "${module.S3hosting.tf_s3_hosted_bucket}"
}
