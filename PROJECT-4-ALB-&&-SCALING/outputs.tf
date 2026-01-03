# output "vpc_id" {
#     value = aws_vpc.main.id 
# }

# output "public_subnet_id" {
#     value = aws_subnet.public_subnet.id
  
# }


# output "private_subnet_id" {
#     value = aws_subnet.private_subnet.id
  
# }

# output "private_ec2_instance_id" {
#   value = aws_instance.private_ec2.id
# }

output "alb_dns_name" {
    value = aws_alb.nginx_alb.dns_name
  
}
