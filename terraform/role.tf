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
      kubernetes_secret.dashboard-secret-certs.metadata.name,
      kubernetes_secret.dashboard-secret-csrf.metadata.name,
      kubernetes_secret.dashboard-secret-key-holder.metadata.name
    ]
    verbs = ["get", "update", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    resource_names = [
      kubernetes_config_map.dashboard-config-map.metadata.name
    ]
    verbs = ["get", "update"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    resource_names = [
      "heapster",
      kubernetes_service.dashboard-metrics-scraper.metadata.name
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
      "http:${kubernetes_service.dashboard-metrics-scraper.metadata.name}",
      kubernetes_service.dashboard-metrics-scraper.metadata.name
    ]
    verbs = ["get"]
  }
}