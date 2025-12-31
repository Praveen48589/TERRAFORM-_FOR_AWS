terraform {
  
}

# Number list :: 
variable "num_list" {
    type = list(number)
    default = [1, 2, 3, 4, 5]
  
}

# Object list :: 
variable "person_list" {
    type = list(object({
      fname = string
      lname = string
    }))
    default = [ {
      fname = "Raju"
      lname = "singh"
      }, {
      fname = "sham"
      lname = "tomar"
    } ]
  
}
# Map list ::

variable "map_list" {
    type = map(number)
    default = {
      "one" = 1
      "two" = 2
      "three" = 3
      "four" = 4
    } 
}

# Double of list >>



# Calculations <<

locals {
  mult = 2 * 2
  add = 2 + 2
  eq = 2!= 3
 
# double number list :: 
  double = [for num in var.num_list: num*2]
# odd number in number list :: 
  odd = [for num in var.num_list: num if num %2 != 0]
# How to get person from person list ::
  fname = [for person in var.person_list: person.fname ]

# Work with map :: 
  map_info = [for key, value in var.map_list : key]   # key and value 

  double_map = {for key, value in var.map_list : key => value*2}

}


output "Add" {
    value = local.add
}

output "Mult" {
    value = local.mult
    #value = local.eq     >> it is give boolean value :: 
}

# output "output" {
#     value = var.num_list   >> << output of the num list >>  
  
# }

output "output" {
    #value = local.double
    #value = local.odd
    #value = local.fname  # to print full name
    #value = local.map_info
    value = local.double_map 
  
}

# How to get fullname of persons from person list >>




