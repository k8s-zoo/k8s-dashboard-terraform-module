resource "kubernetes_role" "dashboard-role" {
  metadata {
    labels    = var.labels
    name      = var.role_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    resource_names = [
      kubernetes_secret.dashboard-secret-certs.metadata.0.name,
      kubernetes_secret.dashboard-secret-csrf.metadata.0.name,
      kubernetes_secret.dashboard-secret-key-holder.metadata.0.name
    ]
    verbs = ["get", "update", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    resource_names = [
      kubernetes_config_map.dashboard-config-map.metadata.0.name
    ]
    verbs = ["get", "update"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    resource_names = [
      "heapster",
      kubernetes_service.dashboard-metrics-scraper.metadata.0.name
    ]
    verbs = ["proxy"]
  }

  rule {
    api_groups = [""]
    resources  = ["services/proxy"]
    resource_names = [
      "heapster",
      "http:heapster:",
      "https:heapster:",
      "http:${kubernetes_service.dashboard-metrics-scraper.metadata.0.name}",
      kubernetes_service.dashboard-metrics-scraper.metadata.0.name
    ]
    verbs = ["get"]
  }

  depends_on = [
    kubernetes_secret.dashboard-secret-certs,
    kubernetes_secret.dashboard-secret-csrf,
    kubernetes_secret.dashboard-secret-key-holder,
    kubernetes_service.dashboard-metrics-scraper,
  ]
}