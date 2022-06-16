locals {
  env_variables = read_terragrunt_config("${get_parent_terragrunt_dir()}/dev/env.hcl")

  aws_region        = local.env_variables.locals.aws_region
  environment       = local.env_variables.locals.environment
  state_environment = local.env_variables.locals.state_environment
  business_unit     = local.env_variables.locals.business_unit
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "${local.business_unit}-${local.state_environment}-terraform-state"

    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "${local.business_unit}-state-lock"
  }
}

inputs = merge(
  local.env_variables.locals,
  {
    "owner"         = "Flugel",
    "business_unit" = "${local.business_unit}",
  },
  