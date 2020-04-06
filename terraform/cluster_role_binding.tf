resource "kubernetes_cluster_role_binding" "dashboard-cluster-role-binding" {
  metadata {
    name = var.cluster_role_binding_name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.dashboard-cluster-role.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.service_account.metadata.0.name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
}