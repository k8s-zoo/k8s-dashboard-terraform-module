resource "kubernetes_deployment" "dashboard-deployment" {
  metadata {
    labels = var.labels
    name = var.deployment_name
    namespace = kubernetes_namespace.namespace.metadata.name
  }

  spec {
    replicas = 1
    revision_history_limit = 10
    selector {
      matchLabels = var.deployment_name
    }
    template {
      metadata {
        labels = var.deployment_name
      }
      spec {
        container {
          name = var.deployment_name
          image = "kubernetesui/dashboard:v2.0.0-beta8"
          image_pull_policy = "Always"

          port {
            container_port = 8443
            protocol = "TCP"
          }

          args = [
            "--auto-generate-certificates",
            "--namespace=kubernetes-dashboard"
          ]

          volume_mount {
            name = "kubernetes-dashboard-certs"
            mount_path = "/certs"
          }

          volume_mount {
            mount_path = "/tmp"
            name = "tmp-volume"
          }

          liveness_probe {
            http_get {
              scheme = "HTTPS"
              path = "/"
              port = 8443
            }

            initial_delay_seconds = 30
            period_seconds = 30
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem = true
            run_as_user = 1001
            run_as_group = 2001
          }
        }
        volume {
          name = "kubernetes-dashboard-certs"
          secret {
            secret_name = "kubernetes-dashboard-certs"
          }
        }
        volume {
          name = "tmp-volume"
          empty_dir {}
        }
        service_account_name = var.service_account_name
        toleration {
          key = "node-role.kubernetes.io/master"
          effect = "NoSchedule"
        }
        node_selector = {
          beta.kubernetes.io/os = "linux"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "dashboard-metrics-scraper" {
  metadata {
    labels = var.labels
    name = var.metrics-scraper_deployment_name
    namespace = kubernetes_namespace.namespace.metadata.name
  }

  spec {
    replicas = 1
    revision_history_limit = 10
    selector {
      matchLabels = var.metrics-scraper_deployment_name
    }
    template {
      metadata {
        labels = var.metrics-scraper_deployment_name
      }
      spec {
        container {
          name = var.metrics-scraper_deployment_name
          image = "kubernetesui/metrics-scraper:v1.0.1"

          port {
            container_port = 8000
            protocol = "TCP"
          }

          volume_mount {
            mount_path = "/tmp"
            name = "tmp-volume"
          }

          liveness_probe {
            http_get {
              scheme = "HTTPS"
              path = "/"
              port = 8000
            }

            initial_delay_seconds = 30
            period_seconds = 30
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem = true
            run_as_user = 1001
            run_as_group = 2001
          }
        }
        volume {
          name = "tmp-volume"
          empty_dir {}
        }
        service_account_name = var.service_account_name
        toleration {
          key = "node-role.kubernetes.io/master"
          effect = "NoSchedule"
        }
        node_selector = {
          beta.kubernetes.io/os = "linux"
        }
      }
    }
  }
}



