resource "kubernetes_deployment" "dashboard-deployment" {
  metadata {
    labels    = var.labels
    name      = var.deployment_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    replicas               = 1
    revision_history_limit = 10
    selector {
      match_labels = var.labels
    }
    template {
      metadata {
        labels = var.labels
        annotations = {
          "seccomp.security.alpha.kubernetes.io/pod" = "runtime/default"
        }
      }
      spec {
        container {
          name              = var.deployment_name
          image             = var.kubernetesui_dashboard_docker_image
          image_pull_policy = "Always"

          port {
            container_port = 8443
            protocol       = "TCP"
          }

          args = [
            "--auto-generate-certificates",
            "--namespace=kubernetes-dashboard"
          ]

          volume_mount {
            name       = kubernetes_secret.dashboard-secret-certs.metadata.0.name
            mount_path = "/certs"
          }

          volume_mount {
            mount_path = "/tmp"
            name       = "tmp-volume"
          }

          liveness_probe {
            http_get {
              scheme = "HTTPS"
              path   = "/"
              port   = 8443
            }

            initial_delay_seconds = 30
            period_seconds        = 30
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = true
            run_as_user                = 1001
            run_as_group               = 2001
          }
        }
        volume {
          name = kubernetes_secret.dashboard-secret-certs.metadata.0.name
          secret {
            secret_name = kubernetes_secret.dashboard-secret-certs.metadata.0.name
          }
        }
        volume {
          name = "tmp-volume"
          empty_dir {}
        }
        service_account_name            = kubernetes_service_account.service_account.metadata.0.name
        automount_service_account_token = true
        toleration {
          key    = "node-role.kubernetes.io/master"
          effect = "NoSchedule"
        }
        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.namespace,
    kubernetes_service_account.service_account,
    kubernetes_secret.dashboard-secret-certs,
    kubernetes_service.dashboard-service
  ]
}

resource "kubernetes_deployment" "dashboard-metrics-scraper" {
  metadata {
    labels    = var.labels
    name      = var.metrics-scraper_deployment_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    replicas               = 1
    revision_history_limit = 10
    selector {
      match_labels = {
        k8s-app = var.metrics-scraper_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          k8s-app = var.metrics-scraper_deployment_name
        }
        annotations = {
          "seccomp.security.alpha.kubernetes.io/pod" = "runtime/default"
        }
      }
      spec {
        container {
          name  = var.metrics-scraper_deployment_name
          image = var.metrics_scraper_docker_image

          port {
            container_port = 8000
            protocol       = "TCP"
          }

          volume_mount {
            mount_path = "/tmp"
            name       = "tmp-volume"
          }

          liveness_probe {
            http_get {
              scheme = "HTTPS"
              path   = "/"
              port   = 8000
            }

            initial_delay_seconds = 30
            period_seconds        = 30
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = true
            run_as_user                = 1001
            run_as_group               = 2001
          }
        }
        volume {
          name = "tmp-volume"
          empty_dir {}
        }
        service_account_name            = kubernetes_service_account.service_account.metadata.0.name
        automount_service_account_token = true
        toleration {
          key    = "node-role.kubernetes.io/master"
          effect = "NoSchedule"
        }
        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.namespace,
    kubernetes_service_account.service_account,
    kubernetes_service.dashboard-metrics-scraper,
    kubernetes_deployment.dashboard-deployment
  ]
}



