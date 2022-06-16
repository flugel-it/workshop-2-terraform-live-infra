locals {
  env_variables = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment   = local.env_variables.locals.environment

}

terraform {
  source = "github.com/flugel-it/workshop-2-terraform-module"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  ami           = "ami-ebd02392"
  instance_type = "t2.micro"
   tags = {
    "Name" = "${local.environment}"
}
