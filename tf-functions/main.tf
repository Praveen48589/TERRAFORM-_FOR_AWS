terraform {}

locals {
  value = "Hello World"
}

variable "string_list" {
    type = list(string)
    default = [ "praveen", "sarthak", "arjun" ]
  
}

output "output" {
    #value = lower(local.value)
    #value = startswith(local.value, "Hello")
    #value = split(" ", local.value)
    # value = abs(-15)   >> plus 15 >>
    # value = min(1,2,3,4,5,6) >> minimum value ::
    value = length(var.string_list[0]) # length of the praveen :: 
  
}