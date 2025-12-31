variable "region" {
    description = "name of region"
    default = "ap-south-1"
}

variable "ami" {
    description = "ami of ubuntu in mumbai region"
    default = "ami-02b8269d5e85954ef"
  
}

variable "type" {
    description = "instance_type"
    default = "t3.micro"
  
}