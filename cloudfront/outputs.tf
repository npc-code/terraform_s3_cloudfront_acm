output "cloud_front_domain_name" {
    value = aws_cloudfront_distribution.s3_site_dist.domain_name 
}