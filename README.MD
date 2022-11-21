#
#
IN root dir, we have multiple files for different purposes

locals.tf => is used to declare workspaces for stagging and production enviornment
providers.tf => uesd to provide aws provider and region for terraform
terraform.tfvars=> Initlize variables values for VPC module
variables.tf=> Declare variable values for root / VPC module
main.tf=> Initlize VPC module by give path for the module defination and pass variables from root dir variable file

IN module dir, we have define module for VPC

datasources.tf=> used to define datasource(dynamic value) to get available az's from AWS for a specific region and get my publuc ip
locals.tf => is used to declare workspaces for stagging and production enviornment
variables.tf=> Declare variable values VPC module
output.tf=> get output to return to root module
vpc.tf=> Define VPC module with Public, Private subnet and Internet gateway. (Public subnet has route to internet and Private subnet has route only to within VPC)

For Staging Envirnment:

 terraform workspace list  --> (show all terraform workspaces in the project)
 * default(staging) check local.tf files in the module vpc
 terraform init --> initilize backend(local) and download plugin for the provider
 terraform plan --> which resources terraform will deploy in the AWS Provider
 terraform apply/destroy --> to deploy and destroy the Infrastructure

For Production Envirnment:
  terraform workspace new prod -->  (create new workspace with name prod)
Created and switched to workspace "prod"!
 terraform init --> initilize backend(local) and download plugin for the provider
 terraform plan --> which resources terraform will deploy in the AWS Provider
 terraform apply/destroy --> to deploy and destroy the Infrastructure