
# ---- Variables for VPC Module ---- #

variable "vpc_cidr" {
  type = string
}


variable "number_of_public_subnets" {
  type = number
  validation {
    condition     = var.number_of_public_subnets > 0 && var.number_of_public_subnets <= 4
    error_message = "Must be in between 1 and 4"
  }
}

variable "number_of_private_subnets" {
  type = number
  validation {
    condition     = var.number_of_private_subnets > 0 && var.number_of_private_subnets <= 4
    error_message = "Musat be in between 1 and 4"
  }
}

# ---- Variables for Root Modules ---- #

variable "aws_region" {
  type = string
}

# ---- Variables for All Modules ---- #

variable "project_tags" {
  type = map(any)
  default = {
    Enviornment = "Stagging"
    IAC         = "AWS usgin Terrafrom"
  }
}