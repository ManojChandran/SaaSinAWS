#----root/outputs.tf-----

output "S3 Hosted bucket name" {
  value = "${module.S3hosting.tf_s3_hosted_bucket}"
}
output "Cloudfront distrubution domain" {
  value = "${module.Cldfrntdistro.tf_Cld_dist_domain_name}"
}
output "Cloudfront distrubution domain Status" {
  value = "${module.Cldfrntdistro.tf_Cld_dist_status}"
}
output "API gateway ID" {
  value = "${module.Apigateway.tf_api_gateway_id}"
}

output "VPC ID" {
  value = "${module.vpc_igw.vpc_id}"
}
output "VPC IGW" {
  value = "${module.vpc_igw.igw_id}"
}
output "VPC Default Routetable" {
  value = "${module.vpc_igw.default_route_table_id}"
}
output "VPC Cluster ID" {
  value = "${module.ECSCluster.ecs_cluster_id}"
}
output "Public subnets" {
  value = ["${module.PublicSubnet.vpc_public_subnets}"]
}
output "Private subnets" {
  value = ["${module.PrivateSubnet.vpc_private_subnets}"]
}
output "RDS subnets" {
  value = ["${module.RDSSubnet.vpc_RDS_subnets}"]
}
output "VPC Flowlogs" {
  value = "${module.Flowlogs.tf_VPC_flowlogs_id}"
}
