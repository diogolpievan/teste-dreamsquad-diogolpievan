output "website_url" {
    description = "Static Frontend S3 Public URL"
    value = aws_s3_bucket_website_configuration.frontend_website.website_endpoint
}
