# Netic AWS Assume Role Terraform Module

## Supported Terraform Versions

Terraform 0.12

## Usage

```hcl
module "assume_roles" {
  source  = "github.com/neticdk/tf-aws-assume-role"

  aws_account_id         = "123456789012"

  saml_account_id        = "210987654321"
  saml_identity_provider = "my-provider"
  saml_roles = {
    "my-role" = "My Role",
  }

  aws_service_name  = "ec2"
  aws_service_roles = {
    "my-other-role" = "My Other Role",
  }

  aws_account_roles = {
    "my-third-role" = "My Third Role",
  }
}
```
<!---BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK--->
<!---END OF PRE-COMMIT-TERRAFORM DOCS HOOK--->

# Copyright
Copyright (c) 2019 Netic A/S. All rights reserved.

# License
MIT Licened. See LICENSE for full details.

