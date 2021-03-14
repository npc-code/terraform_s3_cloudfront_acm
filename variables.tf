variable "region" {
  type    = string
  default = "us-east-2"
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