# Crear bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Environment = "dev"
    Owner       = var.owner
    Project     = "Betek"
  }
}

# Hosting estático
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.index_file
  }
}

# Permitir acceso público
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política pública
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  depends_on = [aws_s3_bucket_public_access_block.this]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

# Subir index.html
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.this.id
  key    = var.index_file
  source = "../../index.html" # 👈 importante por la ruta
  content_type = "text/html"

  tags = {
    Environment = "dev"
    Owner       = var.owner
    Project     = "Betek"
  }
}