#----03_Cldfrontdistro/outputs.tf----

output "tf_s3_dist_domain_name" {
  value = "${aws_cloudfront_distribution.tf_s3_distribution.origin.domain_name}"
}
