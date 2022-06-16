locals {
  owner             = "Flugel"
  business_unit     = "bsunit"
  aws_region        = "us-east-1"
  region            = local.aws_region
  environment       = "staging"
  state_environment = local.environment
}