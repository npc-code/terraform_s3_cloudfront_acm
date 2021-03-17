resource "aws_iam_user" "deployment_user" {
    count = var.use_deployment_user ? 1 : 0
  name = "deploymentuser-${random_id.user[count.index].hex}"


  tags = {
    tag-key = "tag-value"
  }
}

resource "random_id" "user" {
    count = var.use_deployment_user ? 1: 0
  byte_length = 8
}

data "template_file" "deployment_policy_file" {
    count = var.use_deployment_user ? 1: 0
    template = file("${path.module}/policies/deployment_policy.json")
      vars = {
           aws_s3_bucket_arn = var.bucket_arn
           aws_cloudfront_dist_arn = aws_cloudfront_distribution.s3_site_dist.arn
      }
  }

resource "aws_iam_policy" "deployment_policy" {
     count = var.use_deployment_user ? 1: 0
    name        = "deployment_policy-${random_id.user[count.index].hex}"
    description = "policy to allow for loading of s3 resources and refreshing cloudfront"
    policy      = data.template_file.deployment_policy_file[0].rendered
}  

resource "aws_iam_user_policy_attachment" "deployment-attach" {
     count = var.use_deployment_user ? 1: 0
    user       = aws_iam_user.deployment_user[0].name
    policy_arn = aws_iam_policy.deployment_policy[0].arn
}

resource "aws_iam_access_key" "deployment_user_access_key" {
  user    = aws_iam_user.deployment_user[0].name
}

