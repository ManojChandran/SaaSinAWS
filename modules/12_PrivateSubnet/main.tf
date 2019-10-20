#----myPrivateSubnet/main.tf----

# get availability zone from specified AWS region
data "aws_availability_zones" "available" {}

# Private Route table
resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id  = "${var.vpc_route_table_id}"

  tags {
    Name = "tf_private"
  }
}

# creating private subnet
resource "aws_subnet" "tf_private_subnet" {
  count                   = "${var.vpc_private_subnet_count}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.vpc_private_cidrs[count.index]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "tf_private_${count.index + 1}"
  }
}

# Associating public subnet route table
resource "aws_route_table_association" "tf_public_assoc" {
  count          = "${aws_subnet.tf_private_subnet.count}"
  subnet_id      = "${aws_subnet.tf_private_subnet.*.id[count.index]}"
  route_table_id = "${aws_default_route_table.tf_private_rt.id}"
}
