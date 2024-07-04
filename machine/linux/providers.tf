terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.47.0"
    }
    circleci = {
      source  = "kelvintaywl/circleci"
      version = "1.0.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
  default_tags {
    tags = var.aws_tags
  }
}
