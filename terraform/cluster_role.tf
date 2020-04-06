resource "kubernetes_cluster_role" "dashboard-cluster-role" {
  metadata {
    labels = var.labels
    name   = var.cluster_role_name
  }

  rule {
    api_groups = ["metrics.k8s.io"]
    resources  = ["pods", "nodes"]
    verbs      = ["get", "list", "watch"]
  }
}