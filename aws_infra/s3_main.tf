resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-quick-project-bucket"
  tags = {
    Description = "Bucket deployed for own use case"
  }
}

resource "aws_s3_object" "json_object" {
  content = "admin-policy.json"
  key     = "policy/admin/admin-policy.json"
  bucket  = aws_s3_bucket.my_bucket.id
}
