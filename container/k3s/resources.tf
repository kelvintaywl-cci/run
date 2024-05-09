resource "circleci_runner_resource_class" "container_k3s" {
  resource_class = "${local.namespace}/${local.resource_class}"
  description    = "AWS EC2 (k3s) Container Runner 3 (Ubuntu 22.04, single-node)"
}

resource "circleci_runner_token" "admin" {
  resource_class = circleci_runner_resource_class.container_k3s.resource_class
  nickname       = "admin"
}

data "http" "github_keys" {
  url = "https://github.com/${var.github_username}.keys"
  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_lightsail_key_pair" "gh_key_pair" {
  name = "kelvintaywl-github_key-k3s"
  # NOTE: in my case, i wanted the 2nd public key
  public_key = element(compact(split("\n", data.http.github_keys.response_body)), 1)
}

# Create a new GitLab Lightsail Instance
resource "aws_lightsail_instance" "circleci_runner3_k3s" {
  count             = 1
  name              = format("%s_%02d", "container_k3s_aws_lightsail_ubuntu22_x86_64", count.index)
  availability_zone = "${var.aws_region}a"
  blueprint_id      = "ubuntu_22_04"
  # 1 GB ram, 2 vCPUs, 40 GB disk, $7/month
  # bare minimum for recommendations on k3s:
  # https://docs.k3s.io/installation/requirements#hardware
  bundle_id     = "micro_3_0"
  key_pair_name = aws_lightsail_key_pair.gh_key_pair.name

  user_data = templatefile(
    "${path.module}/tmpl/user_data.sh.tftpl",
    {
      token          = circleci_runner_token.admin.token
      resource_class = circleci_runner_resource_class.container_k3s.resource_class
      namespace      = local.namespace
    }
  )
}

output "machine3_runner_ip" {
  value       = aws_lightsail_instance.circleci_runner3_k3s[*].public_ip_address
  description = "IP address"
}

output "machine3_runner_user" {
  value       = aws_lightsail_instance.circleci_runner3_k3s[*].username
  description = "username"
}
