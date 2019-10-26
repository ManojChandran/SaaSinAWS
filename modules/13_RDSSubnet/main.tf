#----13_RDSSubnet/main.tf----

# get availability zone from specified AWS region
data "aws_availability_zones" "available" {}

# creating RDS subnet
resource "aws_subnet" "tf_RDS_subnet" {
  count                   = "${length(var.vpc_rds_cidrs)}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.vpc_rds_cidrs[count.index]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "tf_RDS_${count.index + 1}"
  }
}

# RDS subnet group
#resource "aws_db_subnet_group" "tf_rds_subnetgroup" {
#    name = "tf_rds_subnetgroup"
#
#    subnet_ids = ["${aws_subnet.tf_RDS_subnet.*.id}"]
#    tags = {
#      Name = "tf_RDS_sng"
#    }
#}
