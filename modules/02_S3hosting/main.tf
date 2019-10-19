#----02_S3hosting/main.tf----

resource "aws_s3_bucket" "tf_s3_host_bucket" {
  bucket = "${var.website_bucket_name}"
  acl = "public-read"

  tags {
    Name = "tf_s3hosting_bucket"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT","POST"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = 3000
  }

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.website_bucket_name}/*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

}

# AWS S3 bucket for www-redirect
resource "aws_s3_bucket" "tf_s3_host_bucket_redirect" {
  bucket = "www.${var.website_bucket_name}"
  acl = "public-read"

  website {
    redirect_all_requests_to = "${var.website_bucket_name}"
  }
}
