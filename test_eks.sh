#!/bin/sh

echo "Get EKS credentials"
cd terraform/infrastructure
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

EKSPOD=$(kubectl get pods -n demo-app-namespace -o custom-columns=NAME:.metadata.name --no-headers)

echo "Use curl or open a web browser to localhost:8080"
kubectl port-forward $EKSPOD -n demo-app-namespace 8080:8080
