# Module: kubernetes-dashboard

## Introduction

Terraform modules deploys the Kubernetes Dashboard.


### Development

```hcl-terraform

# Connecting to AWS EKS
   
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

```
    
## Overview

- **Maintainer**: mishalshah92@gmail.com