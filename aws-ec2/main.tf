terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}

provider "aws" {
    region = var.region
  # Configuration options
}

resource "aws_instance" "myweb_server" {
    ami = "ami-0b83c7f5e2823d1f4"
    instance_type = "t3.micro"

    tags = {
      Name = "SampleServer"
    }
  
}