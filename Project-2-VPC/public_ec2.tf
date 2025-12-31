resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "allow ssh and http"
    vpc_id = aws_vpc.main.id

    ingress {
        description = "allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["223.184.182.11/32"]// for access private ec2 by public subnet that,s called bastion host :: 
    }

    ingress {
        description = "allow http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-sg"
    }
  
}


# CREATE EC2 AND CONNECT WITH PUBLIC SUBNET :: << INSIDE VPC >>

resource "aws_instance" "web" {
    ami = "ami-0f5ee92e2d63afc18"
    instance_type = var.instance_type
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = var.key_name
    associate_public_ip_address = true

    tags = {
        Name = "web-ec2"
    }
  
}