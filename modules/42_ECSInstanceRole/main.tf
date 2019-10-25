#----42_ECSInstancerole/main.tf-----

resource "aws_iam_role" "tf_ecs_instance_role" {
    name                = "tf_ecs_instance_role"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.tf_ecs-instance-policy.json}"
}

data "aws_iam_policy_document" "tf_ecs_instance_policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role_policy_attachment" "tf_ecs_instance_role_attachment" {
    role       = "${aws_iam_role.tf_ecs_instance_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
