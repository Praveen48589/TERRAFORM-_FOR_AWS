terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
  }
  backend "s3" {
    bucket = "demo-s3-bucket-733c997f2960fe4d"
    key = "backend.tfstate"
    region = "ap-south-1"
    
  }
}

provider "aws" {
    region = "eu-north-1"
  # Configuration options
}

resource "aws_instance" "myweb_server" {
    ami = "ami-0b83c7f5e2823d1f4"
    instance_type = "t3.micro"

    tags = {
      Name = "SampleServer"
    }
  
}