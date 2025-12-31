output "instance_public_ip" {
    description = "The public IP of EC2 instance is : "
    value = aws_instance.nginx_server.public_ip
  
}

output "instance_url" {
    description = "The URL of Nginx server is : "
    value = "http://${aws_instance.nginx_server.public_ip}"
  
}