#----03_Cldfrontdistro/outputs.tf----

output "tf_Cld_dist_domain_name" {
  value = "${aws_cloudfront_distribution.tf_s3_distribution.domain_name}"
}

output "tf_Cld_dist_status" {
  value = "${aws_cloudfront_distribution.tf_s3_distribution.status}"
}
