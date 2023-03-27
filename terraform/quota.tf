resource "kubernetes_resource_quota" "quota_devops_challenge" {
  metadata {
    name      = "${local.deploy_name}-resource-quota"
    namespace = local.namespace
  }

  spec {
    hard = {
      # "requests.cpu"    = "180m"
      # "requests.memory" = "100Mi"
      "limits.cpu"      = "1620m"
      "limits.memory"   = "2048Mi"
    }
  }
  depends_on = [
    kubernetes_namespace.namespace_devops_challenge
  ]
}