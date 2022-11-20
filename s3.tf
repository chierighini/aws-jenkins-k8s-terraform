resource "aws_s3_bucket" "backend-bucket" {
  bucket = "unique-bucket-name-0"
  tags = {
    Name = "Bucket 0"
  }
}

resource "aws_s3_bucket_acl" "bucket-0-acl" {
  bucket = aws_s3_bucket.backend-bucket.id
  acl    = "private"
}
