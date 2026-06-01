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

resource "aws_key_pair" "terra-key" {
    key_name = "terra-key"
    public_key = file("terra-key.pub")  # paste you public key file name here you can be create by boths keys by using ssh-keygen , name >> terra-key 
}


resource "aws_instance" "my-server" {
    ami = var.ami
    instance_type = var.type
    key_name = aws_key_pair.terra-key.key_name

    vpc_security_group_ids = [
        aws_security_group.sg-group.id
    ]

    root_block_device{
        volume_size = 10
        volume_type = "gp3"
    }

    tags = {
        Name = "Sample-server"
    }
  
}
