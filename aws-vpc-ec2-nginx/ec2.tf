resource "aws_instance" "nginx_server" {
    subnet_id = aws_subnet.public-subnet.id
    ami = "ami-0b83c7f5e2823d1f4"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.nginx-sg.id]
    associate_public_ip_address = true

    user_data = <<-EOF
              #!/bin/bash
              sudo yum install nginx -y
              sudo systemctl start nginx
              EOF

    tags = {
      Name = "Nginx_server"
    }
  
}