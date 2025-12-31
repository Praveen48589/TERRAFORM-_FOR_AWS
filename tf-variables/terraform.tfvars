aws_instance_type = "t3.micro"

ec2_config = {
  v_size = 30
  v_type = "gp2"
}

additional_tags = {
  PROJECT = "MYPROJECT"
  NAME = "MY_SERVER"
}