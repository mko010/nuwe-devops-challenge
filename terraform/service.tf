resource "kubernetes_service_v1" "service_devops_challenge" {
  metadata {
    name      = local.service_name
    namespace = local.namespace
    labels = {
      "app/name" = local.deploy_name
    }
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
    }
  }

  spec {
    internal_traffic_policy = "Cluster"
    port {
      port        = local.port
      protocol    = "TCP"
      target_port = local.port
    }
    selector = {
      "app/name" = local.deploy_name
    }
    session_affinity = "None"
    type             = "ClusterIP"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations
    ]
  }

  depends_on = [
    kubernetes_namespace.namespace_devops_challenge
  ]
}