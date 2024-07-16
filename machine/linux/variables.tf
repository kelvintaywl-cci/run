variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_tags" {
  type        = map(string)
  default     = {}
  description = "AWS default tags for all resources"
}

variable "public_ssh_key" {
  type        = string
  default     = ""
  description = "Public SSH key used for accessing your AWS Lightsail instance(s)"
}

variable "num_machines" {
  type        = number
  default     = 1
  description = "Fleet size (number of instances)"
}

variable "runner_resource_class" {
  type        = string
  description = "CircleCI Runner resource-class name (e.g., acmeorg/machine-runner-aws-lightsail)"

  validation {
    condition     = can(regex("^.+/.+", var.runner_resource_class))
    error_message = "The Runner resource-class name must match <namespace>/<resource-class>."
  }
}

variable "runner_resource_class_desc" {
  type        = string
  default     = ""
  description = "Description for CircleCI Runner resource-class"
}

variable "runner_token" {
  type        = string
  default     = ""
  sensitive   = true
  description = "CircleCI Runner resource-class token, if already created"
}

variable "lightsail_bundle_id" {
  type        = string
  description = "AWS Lightsail bundle ID. See https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/get-bundles.html"
}

variable "lightsail_blueprint_id" {
  type        = string
  description = "The ID for a virtual private server image. See https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/get-blueprints.html"
}

variable "lightsail_instance_name" {
  type        = string
  description = "Name (identifier) for the AWS Lightsail instance"
}

variable "circleci_hostname" {
  type        = string
  default     = "runner.circleci.com"
  description = "Set this to your CircleCI Server (>= 4.4.x) domain if for Server"
}

variable "custom_config" {
  type        = string
  default = "echo \"replace me\"\necho \"Check custom_config input for this module.\n\""
  description = "Custom configuration used as part of the user-data (provisioning script). Script will be run before starting the CircleCI runner agent."
}
