resource "kubernetes_service_account" "service_account" {
  metadata {
    labels    = var.labels
    name      = var.service_account_name
    namespace = var.namespace_name
  }

  depends_on = [
    kubernetes_namespace.namespace
  ]
}