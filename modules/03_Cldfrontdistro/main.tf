#----03_Cldfrontdistro/main.tf----

resource "aws_cloudfront_distribution" "tf_s3_distribution" {
  origin {
    domain_name = "${var.hosted_website_bucket_name}.s3.amazonaws.com"
    origin_id   = "mywebsite"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Managed by OOUVE"
  default_root_object = "index.html"

  # aliases = ["${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "mywebsite"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }

  tags {
    Environment = "test"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
