resource "aws_security_group" "private_sg" {
  name        = "private_ec2_sg"
  description = "private_sg"
  vpc_id      = aws_vpc.main.id

  # ❌ No ingress rules (SSM does not need inbound access)

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = "ami-00ca570c1b6d79f36"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  # ✅ SSM access (instead of SSH)
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  associate_public_ip_address = false

  tags = {
    Name = "private-ec2"
  }
}
