# K8s-terraform-modules

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

- `$ make deploy-k8s-dashboard`

    It will deploy Kubernetes Dashboard to cluster.
 
- `$ make destroy-k8s-dashboard`

    It will destroy Kubernetes Dashboard to cluster.    
    
## Overview

- **Maintainer**: mishalshah92@gmail.com