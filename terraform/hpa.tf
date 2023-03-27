resource "kubernetes_horizontal_pod_autoscaler_v1" "hpa_devops_challenge" {
  metadata {
    name      = "${local.deploy_name}-hpa"
    namespace = local.namespace
    labels = {
      "app/name" = local.deploy_name
    }
  }

  spec {
    min_replicas = 1
    max_replicas = 3
    scale_target_ref {
      api_version = "apps/v1beta1"
      kind        = "Deployment"
      name        = local.deploy_name
    }
    target_cpu_utilization_percentage = 70
  }
}