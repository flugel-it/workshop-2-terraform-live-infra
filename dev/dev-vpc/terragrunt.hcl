locals {
  env_variables = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment   = local.env_variables.locals.environment

}

terraform {
  source = "github.com/flugel-it/workshop-1-terraform-module"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    vpc_id           = aws_vpc.main.id
    tags = {
      "Name" = "${local.environment}"
    }

}

