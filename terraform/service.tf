resource "kubernetes_service" "dashboard-service" {
  metadata {
    labels    = var.labels
    name      = var.service_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    selector = {
      k8s-app = kubernetes_deployment.dashboard-deployment.metadata.0.name
    }
    port {
      port        = 443
      target_port = 8443
    }
  }
}

resource "kubernetes_service" "dashboard-metrics-scraper" {
  metadata {
    labels    = var.labels
    name      = var.metrics_service_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    selector = {
      k8s-app = kubernetes_deployment.dashboard-metrics-scraper.metadata.0.name
    }
    port {
      port        = 8000
      target_port = 8000
    }
  }
}