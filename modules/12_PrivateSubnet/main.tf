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
    Name = "tf_private_tag_${count.index + 1}"
  }
}

# Associating public subnet route table
resource "aws_route_table_association" "tf_public_assoc" {
  count          = "${aws_subnet.tf_private_subnet.count}"
  subnet_id      = "${aws_subnet.tf_private_subnet.*.id[count.index]}"
  route_table_id = "${aws_default_route_table.tf_private_rt.id}"
}


# Create application load balancer and attach it to private Subnet.
resource "aws_alb" "tf_ecs_load_balancer" {
    name                = "tf-ecs-load-balancer"
#    security_groups     = ["${aws_security_group.test_public_sg.id}"]
    subnets             = ["${aws_subnet.tf_private_subnet.*.id}"]

    tags {
      Name = "tf_ecs_load_balancer"
    }
}

resource "aws_alb_target_group" "tf_ecs_target_group" {
    name                = "tf-ecs-target-group"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              = "${var.vpc_id}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags {
      Name = "tf_ecs_target_group"
    }
}

resource "aws_alb_listener" "tf_alb_listener" {
    load_balancer_arn = "${aws_alb.tf_ecs_load_balancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.tf_ecs_target_group.arn}"
        type             = "forward"
    }
}
