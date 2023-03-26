resource "kubernetes_horizontal_pod_autoscaler_v1" "mdona_cloud_sqlproxy_hpa" {
    metadata {
      name = "application"
      namespace = var.namespace
      labels = {
        "app.kubernetes.io/name" = "application"
      }
    }

    spec {
        min_replicas = 1
        max_replicas = 3
        scale_target_ref {
          api_version = "apps/v1beta1"
          kind = "Deployment"
          name = "application"
        }
        target_cpu_utilization_percentage = 70
    }
}