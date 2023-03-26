resource "kubernetes_service_v1" "mdona_cloud_sqlproxy_service" {
  metadata {
    name = "application-svc"
    namespace = var.namespace
    labels = {
      "app.kubernetes.io/name" = "application"
    }
  }

  spec {
    type = "ClusterIP"

    port {
      name = "svc-tcp-${var.ports[count.index]}"
      port = tonumber(var.ports[count.index])
      protocol = "TCP"
      target_port = "port-tcp-${var.ports[count.index]}"
    }
    
    selector = {
      "app.kubernetes.io/name" = "application"
    }
  }
}