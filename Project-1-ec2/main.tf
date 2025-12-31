terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "my-server" {
    ami = var.ami
    instance_type = var.type

    vpc_security_group_ids = [
        aws_security_group.sg-group.id
    ]

    tags = {
        Name = "Sample-server"
    }
  
}