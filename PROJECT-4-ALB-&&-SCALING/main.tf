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

# STEP : 1 >> CREATE A VPC <<

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "my_vpc"
    }
  
}


# STEP : 2 >> CREATE A INTERNET GATEWAY :: 

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "my_igw"
    }
}

# STEP : 3 >> CREATE A PUBLIC SUBNET ::

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_1
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1a"
    tags = {
        Name = "public_subnet_1"
    }
}



resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_2
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1b"
    tags = {
        Name = "public_subnet_2"
    }
}


# STEP : 4 << CREATE A PRIVATE SUBNET >>

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr
    availability_zone = "ap-south-1a"
    tags = {
      Name = "private_subnet"
    }
  
}


# STEP : 5 << CREATE A ROUTE TABLE >>

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0" // this   cidr means you entire internet all ip,s under ipv4
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "public_rt"
    }
}

resource "aws_route_table_association" "public_association_1" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_association_2" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_rt.id
}


# STEPS TO CONNECT NAT GATEWAY TO PRIVATE SUBNET :: NAT FULL FORM >> NETWORK ADDRESS TRANSLATION::

# STEP : 1 >> ASSIGN EIP TO NAT GATEWAY << EIP - ELASTIC IP >> 

resource "aws_eip" "nat_eip" {
  domain = "vpc"              #DOMAIN MEANS WHERE TO USE EIP ::
  tags = {
    Name = "nat_eip"
  }
}

#STEP : 2 >> TO CREATE GATEWAY

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_1.id
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat_gateway"
  }
}

# STEP : 3 >> TO CREATE ROUTE TABLE WITH NAT GATEWAY

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
    
  }

  tags = {
    Name = "private_rt"
  }
}

# STEP : 4 >> TO CREATE ROUTE TABLE ASSOCIATION ::

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet.id
  
}






