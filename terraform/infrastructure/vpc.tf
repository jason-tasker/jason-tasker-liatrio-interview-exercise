################################################################################
# VPC
################################################################################

data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 6.5"

  name = "${var.project_name}-VPC"
  cidr = var.base_cidr_block

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = [for k, v in local.azs : cidrsubnet(var.base_cidr_block, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.base_cidr_block, 8, k + 4)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.project_name}-eks" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.project_name}-eks" = "shared"
    "kubernetes.io/role/internal-elb"               = 1
  }

  tags = var.tags

}
