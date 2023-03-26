resource "kubernetes_resource_quota" "quota_devops_challenge" {
  metadata {
    name = "${local.deploy_name}-resource-quota"
    namespace = local.namespace
  }

  spec {
    hard = {
      "requests.cpu"           = "190m"
      "requests.memory"        = "310Mi"
      "limits.cpu"             = "1500m"
      "limits.memory"          = "1536Mi"
    }
  }
  depends_on = [
    kubernetes_namespace.namespace_devops_challenge
  ]
}