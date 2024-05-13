# Run!

<p align="center">
  <img src="assets/img/run.jpeg" />
</p>

This repo contains Terraform stacks to deploy the following CircleCI Runners:

- :white_check_mark: Machine (Linux)
- :construction: Machine (Windows)
- :white_check_mark: Container (k3s)

## Set up

Go to the individual folders and run the Terraform stack as needed.

```console
# example: for machine runner

$ cd ./machine/linux
$ terraform init
$ terraform plan -out main.tfplan
$ terraform apply main.tfplan
```

**Note** these stacks assume you have the credentials for the providers as such:

- AWS: using the logged-in profile `ccisup-tf`. Please change this as needed
- CircleCI: using the API token under CIRCLE_TOKEN env var.
