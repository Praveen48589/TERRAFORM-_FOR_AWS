variable "region" {
    description = "name of region"
    type = string
    default = "ap-south-1"
}

variable "ami" {
    description = "ami of ubuntu in mumbai region"
    type = string
    default = "ami-02b8269d5e85954ef"
  
}

variable "type" {
    description = "instance_type"
    type = string
    default = "t3.micro"
  
}