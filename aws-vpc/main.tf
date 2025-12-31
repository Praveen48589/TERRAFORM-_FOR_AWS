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

# create a vpc :

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my_vpc"
    }
  
}

# create a private subnet ::

resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "private-subnet"
    }
}

# create a public subnet ::

resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "public-subnet"
    }
}

#internet gateway ::

resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my-igw"
    }
}

# creating route table :: 

resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }
  
}

resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public-subnet.id
  
}

# create a ec2 instance and connected with the private sub_net and as well as private subnet:: 

resource "aws_instance" "myweb_server" {
    subnet_id = aws_subnet.public-subnet.id
    ami = "ami-0b83c7f5e2823d1f4"
    instance_type = "t3.micro"

    tags = {
      Name = "SampleServer"
    }
  
}