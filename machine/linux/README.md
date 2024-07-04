<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.47.0 |
| <a name="requirement_circleci"></a> [circleci](#requirement\_circleci) | 1.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.47.0 |
| <a name="provider_circleci"></a> [circleci](#provider\_circleci) | 1.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lightsail_instance.circleci_runner3_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance) | resource |
| [aws_lightsail_key_pair.key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_key_pair) | resource |
| [circleci_runner_resource_class.machine_linux](https://registry.terraform.io/providers/kelvintaywl/circleci/1.0.1/docs/resources/runner_resource_class) | resource |
| [circleci_runner_token.admin](https://registry.terraform.io/providers/kelvintaywl/circleci/1.0.1/docs/resources/runner_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_aws_tags"></a> [aws\_tags](#input\_aws\_tags) | AWS default tags for all resources | `map(string)` | `{}` | no |
| <a name="input_lightsail_blueprint_id"></a> [lightsail\_blueprint\_id](#input\_lightsail\_blueprint\_id) | The ID for a virtual private server image. See https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/get-blueprints.html | `string` | n/a | yes |
| <a name="input_lightsail_bundle_id"></a> [lightsail\_bundle\_id](#input\_lightsail\_bundle\_id) | AWS Lightsail bundle ID. See https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/get-bundles.html | `string` | n/a | yes |
| <a name="input_lightsail_instance_name"></a> [lightsail\_instance\_name](#input\_lightsail\_instance\_name) | Name (identifier) for the AWS Lightsail instance | `string` | n/a | yes |
| <a name="input_num_machines"></a> [num\_machines](#input\_num\_machines) | Fleet size (number of instances) | `number` | `1` | no |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | Public SSH key used for accessing your AWS Lightsail instance(s) | `string` | `""` | no |
| <a name="input_runner_resource_class"></a> [runner\_resource\_class](#input\_runner\_resource\_class) | CircleCI Runner resource-class name (e.g., acmeorg/machine-runner-aws-lightsail) | `string` | n/a | yes |
| <a name="input_runner_resource_class_desc"></a> [runner\_resource\_class\_desc](#input\_runner\_resource\_class\_desc) | Description for CircleCI Runner resource-class | `string` | `""` | no |
| <a name="input_runner_token"></a> [runner\_token](#input\_runner\_token) | CircleCI Runner resource-class token, if already created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | Public IP addresses of AWS Lightsail instance(s) |
| <a name="output_public_ssh_key"></a> [public\_ssh\_key](#output\_public\_ssh\_key) | Public key for SSH key set up on AWS Lightsail instance(s) |
| <a name="output_username"></a> [username](#output\_username) | Username of AWS Lightsail instance(s), used for SSH |
<!-- END_TF_DOCS -->