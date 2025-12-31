output "public_ip" {
    description = "public-ip of instance"
    value = aws_instance.my-server.public_ip
}

output "security_group" {
    description = "security group ID"
    value = aws_security_group.sg-group.id
  
}