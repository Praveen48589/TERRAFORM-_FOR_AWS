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
  # Configuration options
}

data "aws_ami" "name" { #generates ami from amazon :: 
  most_recent = true
  owners = [ "amazon" ]
  
}

data "aws_security_group" "name" { # for security groups ::
  tags = {
    ENV = "PROD"
    Name = "my-sg"
  }
  
}

data "aws_availability_zones" "names" { # you can check how many availablity zones are present :: 
  state = "available"
  
}

# To get the account details :: 

data "aws_caller_identity" "name" {
  
}


output "security_group" {
  value = data.aws_security_group.name.id
  
}

output "name" {
  value = data.aws_ami.name.id
  
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.names
  
}

output "caller_info" {
  value = data.aws_caller_identity.name
  
}

# for subnet

data "aws_subnet" "name" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    Name = "private-subnet"
  }
  
}

# create a vpc

data "aws_vpc" "name" {
  tags = {
    Name = "my-vpc"
  }
  
}

resource "aws_instance" "myweb_server" {
    ami = "ami-0b83c7f5e2823d1f4"       # you this replace of it << data.aws_ami.name.id >> but i think aws charge for dyamic data :: 
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.name.id
    security_groups = [ data.aws_security_group.name.id]
    tags = {
      Name = "SampleServer"
    }
  
}