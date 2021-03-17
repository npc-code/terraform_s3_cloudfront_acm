# terraform_s3_cloudfront_acm
Terraform project that will create a s3 bucket with a cloudfront distribution for a static web site served only over https.


## Requirements
- an AWS account
- profile with appropriate permissions
- a route53 hosted zone
- terraform
- web assets for a static site

## Optional Feature
- if the variable "use_deployment_user" is set to "true", an IAM user, a scoped policy for s3 upload and cloudfront invalidation, and access keys will be created.  access keys are for use in automation of the update of your assets (github actions).  if you are using local state, the access keys will show up in your state files.  

## Installation

## Usage




