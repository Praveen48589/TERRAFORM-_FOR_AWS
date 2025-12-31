variable "aws_instance_type" {
    description = "what type of instance you want to create ?"
    type = string
    validation {
      condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
      error_message = "only t3.micro and t2.micro allowed "
    }
  
}

# variable "root_volume_size" {
#     description = "enter the volume size : "
#     type = number
#     default = 20   # if you not provide yhe volume by user :: 
  
# }

# variable "root_volume_type" {
#     type = string
#     default = "gp2"
  
# }


# combine both variable in single variable one ::   
variable "ec2_config" {
    type = object({
      v_size = number
      v_type = string
    })
    default = {
      v_size = 20
      v_type = "gp2"
    }
  
}

variable "additional_tags" {
    type = map(string) # expecting key value pair :: 
    default = {}
}