resource "aws_s3_bucket" "site_bucket" {
  bucket_prefix = var.bucket_prefix
  acl    = "private"
  force_destroy = true

  tags = {
    Name = var.bucket_prefix
  }
}