provider "aws" {
  profile = var.profile
  region  = var.region
  alias   = "main-account"
}

data "aws_route53_zone" "main_zone" {
  name         = var.route_53_zone
  provider     = aws.main-account
  private_zone = false
}

module "s3" {
  source        = "./s3"
  bucket_prefix = "${var.prefix}-site-"
  providers = {
    aws = aws.main-account
  }
}

module "cloudfront" {
  source                      = "./cloudfront"
  bucket_name                 = module.s3.bucket_name
  bucket_arn                 = module.s3.bucket_arn
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  env                         = var.prefix
  s3_origin_id                = "${var.prefix}-npc-code"
  zone_id                     = data.aws_route53_zone.main_zone.zone_id
  domain_name                 = var.domain_name
  use_deployment_user = true

  providers = {
    aws = aws.main-account
  }
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloud_front_domain_name
}

output "cloud_front_dist_id" {
    value = module.cloudfront.cloud_front_dist_id
}

output "s3_bucket_name" {
    value = module.s3.bucket_name
}

output "deployment_user_key" {
    value = module.cloudfront.deployment_user_key
}

output "deployment_user_key_id" {
    value = module.cloudfront.deployment_user_key_id
}

output "deployment_user_name" {
    value = module.cloudfront.deployment_user_name
}