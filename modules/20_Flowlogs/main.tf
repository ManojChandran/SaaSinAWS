#----20_Flowlogs/main.tf----

resource "aws_flow_log" "tf_vpc_flowlogs" {
  iam_role_arn    = "${aws_iam_role.tf_IAM_flowlogs.arn}"
  log_destination = "${aws_cloudwatch_log_group.tf_cloudwatch.arn}"
  traffic_type    = "ALL"
  vpc_id          = "${var.vpc_id}"
}

resource "aws_cloudwatch_log_group" "tf_cloudwatch" {
  name = "tf_cloudwatch"
}

resource "aws_iam_role" "tf_IAM_flowlogs" {
  name = "tf_IAM_flowlogs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "tf_iam_role_policy" {
  name = "tf_iam_role_policy"
  role = "${aws_iam_role.tf_IAM_flowlogs.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
