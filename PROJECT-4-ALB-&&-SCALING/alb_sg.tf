resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    vpc_id = aws_vpc.main.id


    ingress {
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
      Name = "alb-sg"
    }  
}


# create alb

resource "aws_alb" "nginx_alb" {
    name = "nginx-alb"
    internal = false            // internal == true, means alb is private , internal == false, means alb is public anyone can access by dns ::
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = [
        aws_subnet.public_subnet_1.id,
        aws_subnet.public_subnet_2.id
    ]
  
}

# create listerner and conncect with load balancer and target group ::

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_alb.nginx_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.nginx_tg.arn
    }
  
}