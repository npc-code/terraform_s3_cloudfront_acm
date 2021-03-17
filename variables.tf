variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  type    = string
  default = ""
}

variable "domain_name" {
  type        = string
  default     = ""
  description = "domain_name for route53"
}

variable "route_53_zone" {
  type        = string
  description = "route53 hosted zone"
}

variable "prefix" {
  type        = string
  default     = ""
  description = "prefix to use relative to workspace"
}

variable "use_deployment_user" {
    type = bool
    default = false
    description = "option to create an IAM user and attach a policy for use with a github action for deployment on push"
}