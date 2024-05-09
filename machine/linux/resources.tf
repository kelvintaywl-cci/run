resource "circleci_runner_resource_class" "machine_linux" {
  resource_class = "${local.namespace}/${local.resource_class}"
  description    = "AWS EC2 Machine Runner 3 (Ubuntu 22.04)"
}

resource "circleci_runner_token" "admin" {
  resource_class = circleci_runner_resource_class.machine_linux.resource_class
  nickname       = "admin"
}

data "http" "github_keys" {
  url = "https://github.com/${var.github_username}.keys"
  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_lightsail_key_pair" "gh_key_pair" {
  name = "kelvintaywl-github_key"
  # NOTE: in my case, i wanted the 2nd public key
  public_key = element(compact(split("\n", data.http.github_keys.response_body)), 1)
}

# Create a new GitLab Lightsail Instance
resource "aws_lightsail_instance" "circleci_runner3_linux" {
  count             = 1
  name              = format("%s_%02d", "machine3_aws_lightsail_ubuntu22_x86_64", count.index)
  availability_zone = "${var.aws_region}a"
  blueprint_id      = "ubuntu_22_04"
  # 1 GB ram, 2 vCPUs, 40 GB disk, $7/month
  bundle_id     = "micro_3_0"
  key_pair_name = aws_lightsail_key_pair.gh_key_pair.name

  user_data = templatefile(
    "${path.module}/tmpl/user_data.sh.tftpl",
    {
      token    = circleci_runner_token.admin.token
      name     = format("%s_%02d", "machine3_aws_lightsail_ubuntu22_x86_64", count.index)
      hostname = local.runner_host
    }
  )
}

output "machine3_runner_ip" {
  value       = aws_lightsail_instance.circleci_runner3_linux[*].public_ip_address
  description = "IP address"
}

output "machine3_runner_user" {
  value       = aws_lightsail_instance.circleci_runner3_linux[*].username
  description = "username"
}

# resource "aws_instance" "aws_ec2_linux_x86_64" {
#   count = 1

#   ami           = data.aws_ami.ubuntu2204.image_id
#   instance_type = var.aws_ec2_instance_type
#   user_data = templatefile(
#     "${path.module}/tmpl/cloudinit.tftpl",
#     {
#       token    = circleci_runner_token.admin.token
#       name     = format("%s_%02d", "machine3_aws_ec2_linux_2023_x86_64", count.index)
#       hostname = local.runner_host
#     }
#   )
#   key_name = aws_key_pair.aws_key_pair.key_name
#   # FIXME: replace hardcoded existing security groups and subnet
#   security_groups             = ["sg-0473b258fc5ae2ad3"]
#   subnet_id                   = "subnet-88276aff"
#   user_data_replace_on_change = true

#   tags = {
#     Name = format("%s_%02d", "kelvintaywl-cloud-machine-runner3-linux", count.index)
#   }
# }
