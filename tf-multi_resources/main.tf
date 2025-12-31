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


# creating two subnets by using of the count :: 
locals {
  project = "project-01"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${local.project}-vpc"
    }
  
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"    # count.index means every iteration cidr block val change like this  >> 0 , 1, 2
  }
}

output "aws_subnet_id" {
  value = aws_subnet.main[0].id   # it gives subnet one id because aws_subnet have multiple subnets :: 
}


# creating 4-ec2 instances ::

# resource "aws_instance" "main" {
#   ami = "ami-0b83c7f5e2823d1f4"
#   instance_type = "t3.micro"
#   count = 4
#   subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
  
# }

# Task number three :: 

# resource "aws_instance" "main" {
#   ami = var.ec2_config[count.index].ami
#   instance_type = var.ec2_config[count.index].instance_type
#   count = length(var.ec2_config)
#   subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
  
# }

# for_each >>

resource "aws_instance" "main" {
  for_each = var.ec2-map
  instance_type = each.value.instance_type
  ami = each.value.ami
  
  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2-map), each.key) % length(aws_subnet.main))
  tags = {
    Name = "${local.project}-instance-${each.key}"
  } 
  
}