resource "aws_s3_bucket" "mys3bucket" {
  bucket = "${data.aws_caller_identity.caller_id}-bastionHost-bucket"
  
  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-s3-bucket"}))
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.mys3bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "PublicBlocking_bucket" {
  bucket = aws_s3_bucket.mys3bucket.id 
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
