#TODO
#add in logging
#look more closely at cloudfront options, namely additional caching options and pricing
#flesh out website, look at github actions to auto deploy new commits with testing


resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access identity for our dist"
}


resource "aws_cloudfront_distribution" "s3_site_dist" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id = var.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  

  #logging_config {
  #  include_cookies = false
  #  bucket          = "mylogs.s3.amazonaws.com"
  #  prefix          = "myprefix"
  #}

  aliases = [var.domain_name]

  default_cache_behavior {
    #allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = var.env
  }

  viewer_certificate {
      acm_certificate_arn = aws_acm_certificate.cert_request.arn
      ssl_support_method = "sni-only"
      minimum_protocol_version = "TLSv1.2_2019"
  }
  
  
}

#looked at https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn/blob/master/main.tf for iam policy creation
data "aws_iam_policy_document" "origin_iam_cloudfront" {

  statement {
    sid = "S3GetObjectForCloudFront"

    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::$${bucket_name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["$${cloudfront_origin_access_identity_iam_arn}"]
    }
  }

  statement {
    sid = "S3ListBucketForCloudFront"

    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::$${bucket_name}"]

    principals {
      type        = "AWS"
      identifiers = ["$${cloudfront_origin_access_identity_iam_arn}"]
    }
  }
}

data "template_file" "default" {
  template = data.aws_iam_policy_document.origin_iam_cloudfront.json
  vars = {
      bucket_name = var.bucket_name
      cloudfront_origin_access_identity_iam_arn = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
  }

}

resource "aws_s3_bucket_policy" "default" {
    bucket = var.bucket_name
    policy = data.template_file.default.rendered
}
