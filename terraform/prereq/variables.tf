variable "aws_region" {
  description = "AWS Deployment Region"
  default     = "us-east-1"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  default     = "tasker-liatrio-test"
  type        = string
}

variable "base_cidr_block" {
  description = "Base CIDR block for VPC and Subnets"
  default     = "10.0.0.0/16"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes Version"
  default     = "1.33"
  type        = string
}

variable "tags" {
  description = "Tags"
  default     = {}
  type        = map(string)
}
