# AWS S3 bucket module

## Description
This module is used to deploy an AWS EC2 instance as well as an Amazon Virtual Private Cloud (VPC).

## Requirements
These are the requirements for this module.

|    | Terraform |
|:--:|-----------|
| >= |   1.0.11  |

|    |   Terragrunt    |
|:--:|-----------|
| >= |  0.26.7   |

## Setup

1. Clone terraform modules repository at the top level directory

```bash
git clone git@github.com:flugel-it/workshop-live-infra.git
```

2. Configure your environment with the correct AWS profile

```bash
export AWS_PROFILE=<profile name>
```

3. Optional: Initialize each environment's resource you're going to work on

  * To initialize all the resources

  ```bash
  ./scripts/initialize.sh <environment> # environment: dev, staging
  ```

  * To initialize only one resource

  ```bash
  cd <environment>/<resource>  # ex: dev/vpc
  terragrunt init
  ```

Terragrunt takes care of creating the appropiate resources for tracking
 infrastructure state remotely.

4. Review the changes to be applied

  * For the whole environment

  ```bash
  cd <environment>/  # ex: dev/
  terragrunt plan-all
  ```

  * For only one resource

  ```bash
  cd <environment>/<resource>  # ex: dev/vpc
  terragrunt plan
  ```

5. Apply your changes

  * For the whole environment

  ```bash
  cd <environment>/  # ex: dev/
  terragrunt apply-all
  ```

  * For only one resource

  ```bash
  cd <environment>/<resource>  # ex: dev/vpc
  terragrunt apply
  ```

## Region

The deploy region is configured on a per-environment basis, and loaded
 in the root `terragrunt.hcl` config on execution.

This region configuration is held in each environment directory's
 `env.hcl` file, and can be modified as follows:

```hcl
// dev/env.hcl
// ...
locals {
  aws_region = "us-east-1"
  // ...
}
//...
```
