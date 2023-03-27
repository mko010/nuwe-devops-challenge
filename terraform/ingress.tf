resource "kubernetes_ingress_v1" "ingress_devops_challenge" {
  metadata {
    name      = local.ingress_name
    namespace = local.namespace
    annotations = {
      "kubernetes.io/ingress.global-static-ip-name": google_compute_global_address.external_ip_devops_challenge.name
    }
  }

  spec {
    default_backend {
      service {
        name = kubernetes_service_v1.service_devops_challenge.metadata[0].name
        port {
          number = 3000
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # metadata[0].annotations,
    ]
  }

  depends_on = [
    google_compute_global_address.external_ip_devops_challenge
  ]
}