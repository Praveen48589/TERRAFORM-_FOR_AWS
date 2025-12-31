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
    bucket = "demo-s3-bucket-${lower(random_id.rand-id.hex)}"# it must be in lower case of uniqui name of id :
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.demo-bucket.bucket
    source = "./myfile.txt"
    key = "mydata.txt"
  
}

output "name" {
    value = random_id.rand-id.hex
  
}