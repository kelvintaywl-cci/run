variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_ec2_instance_type" {
  type = string
  # 2 GB, 2 vCPU
  default = "t3a.small"
}

variable "github_username" {
  type    = string
  default = "kelvintaywl"
}
