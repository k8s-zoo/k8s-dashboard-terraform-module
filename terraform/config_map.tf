resource "kubernetes_config_map" "dashboard-config-map" {
  metadata {
    labels    = var.labels
    name      = var.config_map_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
}