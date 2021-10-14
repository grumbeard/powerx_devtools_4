resource "aws_s3_bucket" "state_backend" {
  bucket = "terraform-state-bucket-grumbeard-powerx-1"
  acl = "private"
  
  versioning {
    enabled = true
  }
  
  lifecycle {
    # Prevents bucket from being deleted by `terraform destroy` command
    prevent_destroy = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.state_backend.id
  block_public_acls = true
  ignore_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
}