resource "kubernetes_role_binding" "dashboard-role-binding" {
  metadata {
    labels    = var.labels
    name      = var.role_binding_name
    namespace = kubernetes_namespace.namespace.metadata.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.dashboard-role.metadata.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.service_account.metadata.name
    namespace = kubernetes_namespace.namespace.metadata.name
  }
}