#----40_ECSCluster/outputs.tf-----

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.tf_ecs_cluster.id}"
}
