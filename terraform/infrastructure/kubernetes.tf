# ################################################################################
# # Kubernetes Deployment
# ################################################################################

# data "aws_ecr_repository" "service" {
#   name = "${var.project_name}-ecr"
# }

# # Namespace
# resource "kubernetes_namespace" "demo_app_namespace" {
#   depends_on = [module.eks]
#   metadata {
#     annotations = {
#       name = "demo-app-namespace"
#     }

#     labels = {
#       app = "demo-app"
#     }

#     name = "demo-app-namespace"
#   }
# }

# # Kubernetes deploy
# resource "kubernetes_deployment" "demo_app_deploy" {
#   depends_on = [kubernetes_network_policy.allow_alb_ingress]
#   metadata {
#     name      = "demo-app-deployment"
#     namespace = "demo-app-namespace"
#     labels = {
#       app = "demo-app"
#     }
#   }

#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "demo-app"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "demo-app"
#         }
#       }
#       spec {
#         container {
#           image = "${data.aws_ecr_repository.service.repository_url}:latest"
#           name  = "demo-app"
#           port {
#             container_port = 8080
#           }
#         }
#       }
#     }
#   }
# }


# # Create LB service on cluster
# resource "kubernetes_service" "demo_app_service" {
#   depends_on = [kubernetes_network_policy.allow_alb_ingress]
#   metadata {
#     name      = "demo-app-service"
#     namespace = "demo-app-namespace"
#   }
#   spec {
#     selector = {
#       app = "demo-app"
#     }
#     port {
#       port        = 80
#       target_port = 8080
#     }
#     type = "LoadBalancer"
#   }
# }

# resource "kubernetes_network_policy" "allow_alb_ingress" {
#   depends_on = [kubernetes_namespace.demo_app_namespace]
#   metadata {
#     name      = "allow-alb-ingress"
#     namespace = "demo-app-namespace"
#   }

#   spec {
#     pod_selector {
#       match_labels = {
#         app = "demo-app"
#       }
#     }

#     policy_types = ["Ingress"]

#     ingress {
#       from {
#         ip_block {
#           # Replace with the CIDR block of your ALB's subnets or the security group's CIDR
#           cidr = "10.0.0.0/16"
#         }
#       }
#       ports {
#         protocol = "TCP"
#         port     = 80 # Or the port your application listens on
#       }
#       ports {
#         protocol = "TCP"
#         port     = 443 # If using HTTPS
#       }
#       ports {
#         protocol = "TCP"
#         port     = 1024
#         end_port = 65535
#       }
#     }
#   }
# }
