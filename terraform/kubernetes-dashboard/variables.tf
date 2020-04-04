variable "cluster_id" {
  type = string
}

variable "service_account_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "namespace_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "service_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "metrics_service_name" {
  type    = string
  default = "dashboard-metrics-scraper"
}

variable "config_map_name" {
  type    = string
  default = "kubernetes-dashboard-settings"
}

variable "role_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "role_binding_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "cluster_role_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "cluster_role_binding_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "deployment_name" {
  type    = string
  default = "kubernetes-dashboard"
}

variable "metrics-scraper_deployment_name" {
  type    = string
  default = "dashboard-metrics-scraper"
}

variable "labels" {
  type = map(string)
  default = {
    k8s-app = "kubernetes-dashboard"
  }
}