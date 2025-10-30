#!/bin/sh

#### Destroy the 2 Terraform stacks and ECR images. Stops up to two times on ECR deletion, so press Q to exit each time
echo "Configure Infrastructure Terraform"
cd terraform/infrastructure/
terraform init --backend-config=../config/backend-infrastructure.conf

echo "Destroy Infrastructure Terraform"
terraform destroy --auto-approve

echo "Configure Prereq Terraform"
cd ../prereq
terraform init --backend-config=../config/backend-prereq.conf

echo "Delete ECR Images"
ECR_URL=$(terraform output -raw ecr_url)
AWS_REGION=$(terraform output -raw region)

IFS='/' read -ra parts <<< "$ECR_URL"

REPO=${parts[1]}

aws ecr batch-delete-image --region $AWS_REGION \
    --repository-name $REPO \
    --image-ids "$(aws ecr list-images --region $AWS_REGION --repository-name $REPO --query 'imageIds[*]' --output json)" || true
aws ecr batch-delete-image --region $AWS_REGION \
    --repository-name $REPO \
    --image-ids "$(aws ecr list-images --region $AWS_REGION --repository-name $REPO --query 'imageIds[*]' --output json)" || true


echo "Destroy Prereq Terraform"
terraform init --backend-config=../config/backend-prereq.conf
terraform destroy --auto-approve

# echo "Update Prereq Terraform"
# terraform apply --auto-approve prereq.tfplan

# echo "Get ECR URL and push container to ECR"
# ECR_URL=$(terraform output -raw ecr_url)

# echo "ECR - $ECR_URL"
# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL
# docker buildx build --platform linux/amd64 -t $ECR_URL:latest .
# docker push $ECR_URL:latest
