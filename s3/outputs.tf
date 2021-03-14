output "bucket_name" {
        value = aws_s3_bucket.site_bucket.id
}

output "bucket_arn" {
        value = aws_s3_bucket.site_bucket.arn
}

output "bucket_domain_name" {
    value = aws_s3_bucket.site_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
    value = aws_s3_bucket.site_bucket.bucket_regional_domain_name
}