#----41_ECSServiceRole/main.tf-----

resource "aws_iam_role" "tf_ecs_service_role" {
    name                = "tf_ecs_service_role"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.tf_ecs-service-policy.json}"
}

resource "aws_iam_role_policy_attachment" "tf_ecs_service_role_attachment" {
    role       = "${aws_iam_role.tf_ecs_service_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "tf_ecs-service-policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ecs.amazonaws.com"]
        }
    }
}
