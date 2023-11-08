provider "aws" {
  region = "eu-central-1"
}

resource "aws_kms_key" "terraform_state_bucket_key" {
  deletion_window_in_days = 7
  enable_key_rotation     = true
  description             = "Used to encrypt objects inside the S3 bucket"
}

resource "aws_kms_alias" "terraform_state_bucket_key_alias" {
  name          = "alias/terraform_state_bucket_key"
  target_key_id = aws_kms_key.terraform_state_bucket_key.key_id
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.terraform_state_bucket_name
}

resource "aws_s3_bucket_acl" "terraform_state_bucket_acl" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_bucket_publilc_access_block" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state" {
  name           = var.terraform_state_dynamo_db_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}