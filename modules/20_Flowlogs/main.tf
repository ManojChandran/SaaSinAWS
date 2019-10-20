#----20_Flowlogs/main.tf----

resource "aws_s3_bucket" "tf_flowlogs_bucket" {
  bucket = "${var.flowlogs_bucket_name}"
  acl = "public-read"

  tags {
    Name = "tf_flowlogs_bucket"
  }
}

resource "aws_flow_log" "vpc_flow_log" {
    iam_role_arn         = "${aws_iam_role.flowlogs_role.arn}"
    log_destination      = "${aws_s3_bucket.tf_flowlogs_bucket.bucket.arn}"
    log_destination_type = "s3"
    traffic_type         = "ALL"
    vpc_id               = "${var.vpc_id}"

}

resource "aws_iam_role" "flowlogs_role" {
  name = "flowlogs_role"
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

resource "aws_iam_role_policy" "flowlogs_role" {
  name = "flowlogs_role"
  role = "${aws_iam_role.flowlogs_role.id}"

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
