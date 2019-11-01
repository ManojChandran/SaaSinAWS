#----43_ECSALBalancer/main.tf-----

# Create application load balancer and attach it to private Subnet.
resource "aws_alb" "tf_ecs_load_balancer" {
    name                = "tf-ecs-load-balancer"
#    security_groups     = ["${aws_security_group.test_public_sg.id}"]
    subnets             = "${var.private_subnets_alb}"

    tags = {
      Name = "tf_ecs_load_balancer"
    }
}

resource "aws_alb_target_group" "tf_ecs_target_group" {
    name                = "ecs-target-group"
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

    tags = {
      Name = "ecs-target-group"
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
