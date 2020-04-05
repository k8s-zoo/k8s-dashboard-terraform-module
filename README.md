# K8s Dashboard Terraform Module

## Introduction

Terraform modules for deploying [Kubernetes Dashboard](https://github.com/kubernetes/dashboard).

Supported Kubernetes Dashboard Version: `v2.0.0-beta8`

**Terraform version**: `0.12.23`

## Example

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

module "kubernetes_dashboard" {
  source = "git@github.com/k8s-zoo/k8s-terraform-modules.git//terraform"
}
```
 
**Variables**: For info on variables, check [file](terraform/variables.tf)
    
## Overview

- **Maintainer**: mishalshah92@gmail.com