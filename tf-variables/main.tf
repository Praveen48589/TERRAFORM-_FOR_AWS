terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "myweb_server" {
    ami = "ami-0b83c7f5e2823d1f4"
    instance_type = var.aws_instance_type

    root_block_device {
      delete_on_termination = true
      volume_size = var.ec2_config.v_size
      volume_type = var.ec2_config.v_type
    }

    tags = merge(var.additional_tags, {
      Name = "Sample_server"
    })
  
}