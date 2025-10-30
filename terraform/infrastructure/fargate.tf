# ################################################################################
# # EKS Module
# ################################################################################

# resource "aws_eks_fargate_profile" "fargate_profile" {
#   depends_on             = [module.eks]
#   cluster_name           = module.eks.cluster_name
#   fargate_profile_name   = "default"
#   pod_execution_role_arn = aws_iam_role.eks_fargate_profile_role.arn
#   subnet_ids             = module.networking.private_subnets

#   selector {
#     namespace = "kube-system"
#   }

#   selector {
#     namespace = "default"
#   }

#   selector {
#     namespace = "demo-app-namespace"
#   }
# }

# resource "aws_iam_role" "eks_fargate_profile_role" {
#   name = "${var.project_name}-eks-fargate-profile-role"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "eks-fargate-pods.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSFargatePodExecutionRolePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
#   role       = aws_iam_role.eks_fargate_profile_role.name
# }
