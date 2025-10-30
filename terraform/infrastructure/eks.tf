################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                    = "${var.project_name}-eks"
  kubernetes_version      = var.kubernetes_version
  endpoint_public_access  = true
  endpoint_private_access = true

  enable_cluster_creator_admin_permissions = true
  enable_irsa                              = true

  #   eks_managed_node_groups = {
  #     one = {
  #       name           = "node-group-1"
  #       instance_types = ["t3.micro"]
  #       capacity_type  = "SPOT"
  #       ami_type       = "AL2023_x86_64_STANDARD"
  #       min_size       = 2
  #       max_size       = 5
  #       desired_size   = 3
  #     }
  #   }

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_subnets

  tags = var.tags
}
