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

variable "zone_id" {
    type = string
    description = "zone id for route53 hosted zone"
}

variable "domain_name" {
    type = string
    description = "domain name to use for site"
}