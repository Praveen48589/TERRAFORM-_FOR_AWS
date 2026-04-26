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
      region = "ap-south-1"
    # Configuration options
  }

  resource "random_id" "rand-id" {
      byte_length = 8
    
  }

  resource "aws_s3_bucket_versioning" "demo-bucket" {
    bucket = aws_s3_bucket.demo-bucket.id

    versioning_configuration {
      status = "Enabled"
    }

    depends_on = [aws_s3_bucket.demo-bucket]
    
  }

  resource "aws_s3_bucket" "demo-bucket" {
      bucket = "demo-s3-bucket-${lower(random_id.rand-id.hex)}"# it must be in lower case of uniqui name of id :
  }

  resource "aws_s3_object" "bucket-data" {
      bucket = aws_s3_bucket.demo-bucket.bucket
      source = "./index.html"
      key = "index.html"
      content_type = "text/html"
    
  }

  resource "aws_s3_bucket_policy" "public_read" {
    bucket = aws_s3_bucket.demo-bucket.id

    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "${aws_s3_bucket.demo-bucket.arn}/*"
        }
      ]
    })
  }


  resource "aws_s3_bucket_public_access_block" "demo-bucket" {
    bucket = aws_s3_bucket.demo-bucket.id
    depends_on = [
      aws_s3_bucket_public_access_block.demo-bucket
    ]

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  }

  resource "aws_s3_bucket_website_configuration" "demo" {
  bucket = aws_s3_bucket.demo-bucket.id

  index_document {
    suffix = "index.html"
  }
  }
