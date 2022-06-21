locals {
  env_variables = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment   = local.env_variables.locals.environment
  region        = local.env_variables.locals.aws_region
  
}

terraform {
  source = "git@github.com:flugel-it/workshop-vpc.git"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  region        = "${local.region}"
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  vpc_tags = {
    "environment" = "${local.environment}"
  }

}

