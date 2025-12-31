resource "aws_security_group" "sg-group" {
    description = "Allow ssh and http"
    name = "my_security_group"

    ingress {
        description = "SSH Allow"     // ingress for incoming traffic ::
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    ingress {
        description = "HTTP Allow"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {                        // egress outgoing traffic :: 
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    

    tags = {
        name = "web-sg"
    }


  
}