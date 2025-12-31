ec2_config = [ {
  ami = "ami-0c4fc5dcabc9df21d" # amazon-linux
  instance_type = "t3.micro"
},{
    ami = "ami-0a716d3f3b16d290c"
    instance_type = "t3.micro"  # ubuntu
} ]

# for_each

ec2-map = {
  "ubuntu" = {
    ami = "ami-0a716d3f3b16d290c"
    instance_type = "t3.micro" 
  },
  "amazon-linux" = {
    ami = "ami-0c4fc5dcabc9df21d"
    instance_type = "t3.micro"
  }
}

