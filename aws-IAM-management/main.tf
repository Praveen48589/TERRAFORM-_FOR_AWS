terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}

locals {
  user_data = yamldecode(file("./users.yml")).users  #yamldecode provide better format for better understanding like key value pairs ::
  user_role_pair  = flatten([for user in local.user_data: [for role in user.role: {
    username = user.username
    role = role

}]])
  
}


output "output" {
    #value = local.user_data[*].username
    value = local.user_role_pair
  
}

resource "aws_iam_user" "users" {
    for_each = toset(local.user_data[*].username)
    name = each.value
  
}

resource "aws_iam_user_login_profile" "profile" {
    for_each = aws_iam_user.users
    user = each.value.name
    password_length = 12

    lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}
  
