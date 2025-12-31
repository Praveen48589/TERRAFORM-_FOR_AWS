resource "aws_security_group" "nginx-sg" {
    vpc_id = aws_vpc.my_vpc.id

    # for inbound rule mean incoming traffic :: 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    #for outbound rulr means outgoing traffic :: 
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"  # -1 means that it is capable for all protocol :: 
      cidr_blocks = ["0.0.0.0/0"] 
    }

    tags = {
      Name = "nginx-sg"
    }
  
}