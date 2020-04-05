# Metrics Server

## Introduction

Terraform modules deploys the [Kubernetes Metric Server](https://github.com/kubernetes-sigs/metrics-server).

Supported Metric Server Version: v0.3.6

## Development

### Example

```hcl-terraform

data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
}

# Connecting to AWS EKS
   
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

module "metrics-server" {
  source = "git@github.com/k8s-zoo/k8s-terraform-modules.git//terraform/metrics-server"
}
```
 
**Variables**: For info on variables, check [file](variables.tf)