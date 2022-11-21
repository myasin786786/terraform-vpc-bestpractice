# Define required settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16.0"
    }
  }
}

# Define Provider
provider "aws" {
  region = var.aws_region
}