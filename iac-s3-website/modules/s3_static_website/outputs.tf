output "website_url" {
  value = "http://${aws_s3_bucket.this.bucket}.s3-website-${var.region}.amazonaws.com"
}