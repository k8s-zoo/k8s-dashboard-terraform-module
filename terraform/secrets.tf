resource "kubernetes_secret" "dashboard-secret-certs" {
  metadata {
    labels    = var.labels
    name      = "kubernetes-dashboard-certs"
    namespace = kubernetes_namespace.namespace.metadata.name
  }
  type = "Opaque"
}

resource "kubernetes_secret" "dashboard-secret-csrf" {
  metadata {
    labels    = var.labels
    name      = "kubernetes-dashboard-csrf"
    namespace = kubernetes_namespace.namespace.metadata.name
  }
  type = "Opaque"
  data = {
    csrf = ""
  }
}

resource "kubernetes_secret" "dashboard-secret-key-holder" {
  metadata {
    labels    = var.labels
    name      = "kubernetes-dashboard-key-holder"
    namespace = kubernetes_namespace.namespace.metadata.name
  }
  type = "Opaque"
}