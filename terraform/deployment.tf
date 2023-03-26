resource "kubernetes_deployment_v1" "mdona_cloud_sqlproxy_deploy" {
    metadata {
        name = local.deploy_name
        namespace = local.namespace
        labels = {
            "app.kubernetes.io/name" = local.deploy_name
        }
    }

    spec {
        progress_deadline_seconds = 600
        replicas = 3
        revision_history_limit = 10
        selector {
            match_labels = {
                "app.kubernetes.io/name" = local.deploy_name
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
                    "app.kubernetes.io/name" = local.deploy_name
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
                            "cpu" = "100m"
                            "memory" = "200Mi"
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
}