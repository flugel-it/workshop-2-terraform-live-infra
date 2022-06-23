locals {
  owner             = "flugel"
  business_unit     = "tfworkshop0622"
  aws_region        = "us-east-1"
  region            = local.aws_region
  environment       = "prod"
  state_environment = local.environment
}