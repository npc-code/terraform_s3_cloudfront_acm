resource "aws_route53_record" "web_endpoint" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name = aws_cloudfront_distribution.s3_site_dist.domain_name 
    zone_id = aws_cloudfront_distribution.s3_site_dist.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "cert_request" {
  domain_name               = var.domain_name
  validation_method         = "DNS"

  tags = {
    Name : var.domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert_request.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}