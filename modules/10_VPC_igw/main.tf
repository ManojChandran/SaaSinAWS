#----10_VPC_igw/main.tf----

# create AWS VPC with specific CIDR
resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf_vpc"
  }
}

# create and attach Internet Gateway
resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags = {
    Name = "tf_igw"
  }
}
