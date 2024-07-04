resource "circleci_runner_resource_class" "machine_linux" {
  # only create if there is no existing Runner token passed in.
  count          = length(var.runner_token) == 0 ? 1 : 0
  resource_class = var.runner_resource_class
  description    = var.runner_resource_class_desc
}

resource "circleci_runner_token" "admin" {
  # only create if there is no existing token passed in.
  count          = length(var.runner_token) == 0 ? 1 : 0
  resource_class = length(var.runner_token) == 0 ? circleci_runner_resource_class.machine_linux[0].resource_class : var.runner_resource_class
  nickname       = "admin"
}

resource "aws_lightsail_key_pair" "key_pair" {
  name       = var.lightsail_instance_name
  public_key = var.public_ssh_key
}

# Create a new GitLab Lightsail Instance
resource "aws_lightsail_instance" "circleci_runner3_linux" {
  count             = var.num_machines
  name              = format("%s_%02d", var.lightsail_instance_name, count.index)
  availability_zone = "${var.aws_region}a"
  blueprint_id      = var.lightsail_blueprint_id
  bundle_id         = var.lightsail_bundle_id
  key_pair_name     = aws_lightsail_key_pair.key_pair.name

  user_data = templatefile(
    "${path.module}/tmpl/user_data.sh.tftpl",
    {
      token = length(var.runner_token) == 0 ? circleci_runner_token.admin[0].token : var.runner_token
      name  = format("%s_%02d", var.lightsail_instance_name, count.index)
      # CircleCI Cloud
      hostname = "runner.circleci.com"
    }
  )
}

output "public_ips" {
  value       = aws_lightsail_instance.circleci_runner3_linux[*].public_ip_address
  description = "Public IP addresses of AWS Lightsail instance(s)"
}

output "username" {
  value       = aws_lightsail_instance.circleci_runner3_linux[0].username
  description = "Username of AWS Lightsail instance(s), used for SSH"
}

output "public_ssh_key" {
  value       = aws_lightsail_key_pair.key_pair.public_key
  description = "Public key for SSH key set up on AWS Lightsail instance(s)"
}
