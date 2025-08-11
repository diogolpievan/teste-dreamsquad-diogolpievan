resource "random_id" "bucket_suffix" {
    byte_length = 4
}

resource "aws_s3_bucket" "frontend" {
    bucket        = "frontend-dreamsquad-test-${random_id.bucket_suffix.hex}"
    force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
    bucket = aws_s3_bucket.frontend.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "index.html"
    }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public" {
    bucket = aws_s3_bucket.frontend.id

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Sid       = "PublicReadGetObject"
                Effect    = "Allow",
                Principal = "*",
                Action    = "s3:GetObject",
                Resource  = "${aws_s3_bucket.frontend.arn}/*"
            }
        ]
    })
    depends_on = [aws_s3_bucket_public_access_block.public_access]
}

resource "aws_s3_object" "index" {
    bucket       = aws_s3_bucket.frontend.id
    key          = "index.html"
    source       = "${path.module}/www/index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "style" {
    bucket       = aws_s3_bucket.frontend.id
    key          = "style.css"
    source       = "${path.module}/www/style.css"
    content_type = "text/css"
}

resource "aws_s3_object" "script" {
    bucket       = aws_s3_bucket.frontend.id
    key          = "script.js"
    source       = "${path.module}/www/script.js"
    content_type = "application/javascript"
}
