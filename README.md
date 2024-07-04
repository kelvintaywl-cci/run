# Run!

<p align="center">
  <img src="assets/img/run.jpeg" />
</p>

This repo contains Terraform modules to deploy the following CircleCI Runners:

- :white_check_mark: Machine (Linux)
- :construction: Machine (Windows)
- :construction: Container (k3s) (pending modularization)

## Example

### Machine (Linux)

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

module "machine3_runners" {
  source = "git::https://github.com/kelvintaywl-cci/run.git//machine/linux"

  aws_region = "ap-northeast-1"
  aws_tags = {
    iac : "true"
  }

  num_machines = 1

  lightsail_blueprint_id  = "ubuntu_22_04"
  lightsail_bundle_id     = "medium_3_0"
  lightsail_instance_name = "kelvintaywl-machine3-runner-medium"

  runner_resource_class      = "kelvintaywl-cci/lightsail-medium"
  runner_resource_class_desc = "AWS Lightsail (medium) Ubuntu 22.04"

  # NOTE: point this to your public SSH key on your local machine, for instance
  public_ssh_key = file(...)
}

output "public_ips" {
  value = module.machine3_runners.public_ips
}
```

**Note** these stacks assume you have the credentials for the providers as such:

- AWS: using the default profile. Otherwise, update the provider config as needed.
- CircleCI: using the API token under CIRCLE_TOKEN env var.
