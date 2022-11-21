variable "vpc_cidr" {
  type = string
}

variable "number_of_public_subnets" {
  type = number
}

variable "number_of_private_subnets" {
  type = number
}

variable "project_tags" {
  type = map(any)
}