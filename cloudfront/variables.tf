variable "env" {
    type = string
    default = "production"
    description = "environment for distribution"
}

variable "s3_origin_id" {
    type = string
    description = "origin id to use"
}

variable "bucket_regional_domain_name" {
    type = string
    description = "bucket region domain name to use as target for distribution"
}

variable "bucket_name" {
    type = string
    description = "bucket name for our origin"
}

variable "bucket_arn" {
    type = string
    description = "bucket arn for our origin"
}

variable "zone_id" {
    type = string
    description = "zone id for route53 hosted zone"
}

variable "domain_name" {
    type = string
    description = "domain name to use for site"
}

variable "use_deployment_user" {
    type = bool
    default = false
    description = "option to create an IAM user and attach a policy for use with a github action for deployment on push"
}