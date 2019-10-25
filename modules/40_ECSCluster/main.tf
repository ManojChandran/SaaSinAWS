#----40_ECSCluster/main.tf-----

# create the cluster
resource "aws_ecs_cluster" "tf_ecs_cluster" {
    name = "${var.tf_ecs_cluster_name}"
}
