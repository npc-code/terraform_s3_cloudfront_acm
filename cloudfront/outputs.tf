output "cloud_front_domain_name" {
    value = aws_cloudfront_distribution.s3_site_dist.domain_name 
}

output "cloud_front_dist_id" {
    value = aws_cloudfront_distribution.s3_site_dist.id 
}

output "deployment_user_name" {
    value = aws_iam_user.deployment_user[0].name 
}

output "deployment_user_key" {
    value = aws_iam_access_key.deployment_user_access_key.secret
}

output "deployment_user_key_id" {
    value = aws_iam_access_key.deployment_user_access_key.id
}