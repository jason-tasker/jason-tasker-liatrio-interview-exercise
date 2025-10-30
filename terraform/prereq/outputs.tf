################################################################################
# Outputs
################################################################################

output "ecr_url" {
  description = "ECR URI"
  value       = aws_ecr_repository.project_ecr.repository_url
}

output "region" {
  description = "AWS Region"
  value       = var.aws_region
}
