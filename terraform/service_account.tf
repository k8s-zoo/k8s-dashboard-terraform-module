resource "kubernetes_service_account" "service_account" {
  metadata {
    labels    = var.labels
    name      = var.service_account_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  depends_on = [
    kubernetes_namespace.namespace
  ]
}


resource "kubernetes_service_account" "eks_admin_service_account" {
  metadata {
    name      = "eks-admin"
    namespace = "kube-system"
  }
}