resource "kubernetes_deployment_v1" "deploy_devops_challenge" {
    metadata {
        name = local.deploy_name
        namespace = local.namespace
        labels = {
            "app/name" = local.deploy_name
        }
    }

    spec {
        progress_deadline_seconds = 600
        replicas = 1
        revision_history_limit = 10
        selector {
            match_labels = {
                "app/name" = local.deploy_name
            }
        }
        strategy {
            rolling_update {
                max_surge = "25%"
                max_unavailable = "25%"
            }
            type = "RollingUpdate"
        }
        template {
            metadata {
                labels = {
                    "app/name" = local.deploy_name
                }
            }
            spec {
                container {
                    image = local.image
                    image_pull_policy = "IfNotPresent"
                    name = local.deploy_name
                    resources {
                        limits = {
                          "cpu" = "500m"
                          "memory" = "400Mi"
                        }
                        requests = {
                            "cpu" = "60m"
                            "memory" = "100Mi"
                        }
                    }
                    termination_message_path = "/dev/termination-log"
                    termination_message_policy = "File"
                }
                dns_policy = "ClusterFirst"
                
                restart_policy = "Always"
                termination_grace_period_seconds = 30

            }
        }
    }
    lifecycle {
        ignore_changes = [
            metadata[0].name,
        ]
    }

    depends_on = [
      kubernetes_namespace.namespace_devops_challenge
    ]
}