# k8s-eks-terraform-modules

## Introduction

Terraform modules for deploying Kubernetes modules.

## Modules
- Kubernetes-dashboard: [terraform/kubernetes-dashboard](terraform/kubernetes-dashboard)
- Metric Server: [terraform/metrics-server](terraform/metrics-server)

## Development

**Terraform version**: 0.12.23

### **How to execute?**

```shell script
$ make [Target]
```

#### **Targets**

- `$ make deploy-eks-master`

    It will create the EKS cluster. This will generate the kubeconfig file with name `kubeconfig.yaml`.
 
- `$ make destroy-eks-master`

    It will destroy the EKS cluster.x    

- `$ make deploy-ec2-nodes`

    It will create the EC2 node group for EKS cluster. This will generate the Kubernetes config map file with
    name `k8s_config_map_aws_auth.yaml`
 
- `$ make destroy-ec2-nodes`

    It will destroy EC2 node group for EKS cluster.

- `$ make deploy-eks-nodes`

    It will create the EKS node group for EKS cluster.
 
- `$ make destroy-eks-nodes`

    It will destroy EKS node group for EKS cluster.
    
## Overview

- **Maintainer**: mishalshah92@gmail.com