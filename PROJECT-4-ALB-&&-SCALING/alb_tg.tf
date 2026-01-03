resource "aws_lb_target_group" "nginx_tg" {
    name = "nginx-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id

    health_check {
      path = "/"
    }
}

# attach target group with private ec2 instance  ::

resource "aws_lb_target_group_attachment" "nginx_attach" {
    target_group_arn = aws_lb_target_group.nginx_tg.arn
    target_id = aws_instance.private_ec2.id
    port = 80
  
}