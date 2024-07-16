# Run!

<p align="center">
  <img src="assets/img/run.jpeg" />
</p>

This repo contains Terraform modules to deploy the following CircleCI Runners:

- :white_check_mark: [Machine (Linux)](machine/linux/)
- :construction: Machine (Windows)
- :construction: Container (k3s) (pending modularization)

## Examples

See examples in each module's README files.

For example, for Machine (Linux), [click here](machine/linux/examples/)

**Note** these stacks assume you have the credentials for the providers as such:

- AWS: using the default profile. Otherwise, update the provider config as needed.
- CircleCI: using the API token under CIRCLE_TOKEN env var.
