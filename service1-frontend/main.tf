resource "random_id" "bucket_suffix" {
    byte_length = 4
}

resource "aws_s3_bucket" "frontend" {
    bucket        = "frontend-dremsquad-test-${random_id.bucket_suffix.hex}"
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
}

resource "aws_s3_object" "index" {
    bucket       = aws_s3_bucket.frontend.id
    key          = "index.html"
    source       = "${path.module}/www/index.html"
    content_type = "text/html"
    acl          = "public-read"
}

resource "aws_s3_object" "style" {
    bucket       = aws_s3_bucket.frontend.id
    key          = "style.css"
    source       = "${path.module}/www/style.css"
    content_type = "text/css"
    acl          = "public-read"
}

resource "aws_s3_object" "script" {
    bucket       = aws_s3_bucket.frontend.id
    key          = "script.js"
    source       = "${path.module}/www/script.js"
    content_type = "application/javascript"
    acl          = "public-read"
}
