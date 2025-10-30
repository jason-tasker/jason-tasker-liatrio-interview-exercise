################################################################################
# Providers
################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.5.0"
    }
  }

  required_version = ">= 1.13.4"
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
