resource "kubernetes_namespace" "namespace_devops_challenge" {
  metadata {
    name = local.namespace

    labels  = {
        owner        = "MediaMarkt"
        application  = local.deploy_name
    }
  }
  lifecycle {
    ignore_changes = [
      metadata[0].annotations
    ]
  }
}

# resource "kubernetes_limit_range" "limit_container_devops_challenge" {
#   metadata {
#     name = "${local.namespace}-limit-range"
#     namespace = local.namespace
#   }
#   spec {
#     limit {
#       type = "Container"
#       default = {
#         cpu    = "100m"
#         memory = "256Mi"
#       }
#       default_request = {
#         cpu    = "10m"
#         memory = "64Mi"
#       }
#     }
#   }

#   depends_on = [
#     kubernetes_namespace.namespace_devops_challenge
#   ]
# }