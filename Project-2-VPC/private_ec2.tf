resource "aws_security_group" "private_sg" {
    name = "private_ec2_sg"
    description = "private_sg"
    vpc_id = aws_vpc.main.id


    ingress {     # only my laptop can access private ec2 by bastion host 
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.web_sg.id] # /128 means only one ip can access inbound rule ::
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] 

    }
}


resource "aws_instance" "private_ec2" {
  ami                         = "ami-00ca570c1b6d79f36"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = {
    Name = "private-ec2"
  }
}
