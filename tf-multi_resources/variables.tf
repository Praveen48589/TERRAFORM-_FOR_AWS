variable "ec2_config" {
  type = list(object({
    ami = string
    instance_type = string

  }))  
  
}


# for_each 

variable "ec2-map" {
    type = map(object({
        ami = string
        instance_type = string
    }))
  
}