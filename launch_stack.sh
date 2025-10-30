#!/bin/sh

echo "Configure Prereq Terraform"
cd terraform/prereq
terraform init --backend-config=../config/backend-prereq.conf
terraform plan -out prereq.tfplan

echo "Update Prereq Terraform"
terraform apply --auto-approve prereq.tfplan

echo "Get ECR URL and push container to ECR"
ECR_URL=$(terraform output -raw ecr_url)

echo "ECR - $ECR_URL"
cd ../../
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL
docker buildx build --platform linux/amd64 -t $ECR_URL:latest .
docker push $ECR_URL:latest

echo "Update Infrastructure Terraform"
cd terraform/infrastructure/
terraform init --backend-config=../config/backend-infrastructure.conf
terraform plan -out infrastructure.tfplan
terraform apply --auto-approve infrastructure.tfplan
