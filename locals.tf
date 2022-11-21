locals {
  infra_env = terraform.workspace == "default" ? "Stagging" : terraform.workspace
}

