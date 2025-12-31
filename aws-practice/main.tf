terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.7.2"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
  # Configuration options
}

resource "random_id" "rand-id" {
    byte_length = 8
  
}

resource "aws_s3_bucket" "demo-bucket" {
    bucket = "demo-bucket${lower(random_id.rand-id.hex)}"
  
}

resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.demo-bucket.bucket
    source = "../proj_static_web/index.html"
    key = "index.html"
    content_type = "text/html" 
  
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.demo-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "web-server" {
    bucket = aws_s3_bucket.demo-bucket.id
    policy = jsonencode({
      Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.demo-bucket.id}/*"
      }
    ]  
    })
  
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
    bucket = aws_s3_bucket.demo-bucket.id

    index_document {
      suffix = "index.html"
    }
  
}

output "name" {
    value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
  
}