resource "kubernetes_service_v1" "service_devops_challenge" {
  metadata {
    name = local.service_name
    namespace = local.namespace
    labels = {
      "app/name" = local.deploy_name
    }
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
    }
  }

  spec {
    allocate_load_balancer_node_ports = true
    external_traffic_policy = "Cluster"
    internal_traffic_policy = "Cluster"
    port {
      port = local.port
      protocol = "TCP"
      target_port = local.port
    }
    selector = {
      "app/name" = local.deploy_name
    }
    session_affinity = "None"
    type = "LoadBalancer"
  }
}