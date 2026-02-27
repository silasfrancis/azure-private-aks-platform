# Private Azure Kubernetes CI/CD Platform

A fully private CI/CD platform built on Microsoft Azure, leveraging a private Kubernetes cluster, Azure Application Gateway for Containers, Infrastructure as Code, and automated deployment pipelines.

This project demonstrates how to design, provision, secure, and operate a production-style private Kubernetes environment on Azure — with no public control plane exposure and a private CI/CD runner inside the virtual network.

---

## Overview

Most production Kubernetes environments operate as private clusters, where the Kubernetes API server is not publicly accessible and can only be reached from within a secure Virtual Network (VNet).

This project demonstrates how to:

- Provision a private AKS cluster
- Route external traffic securely using Azure Application Gateway for Containers
- Deploy workloads using a private Azure DevOps self-hosted runner
- Configure infrastructure using Terraform
- Manage configuration and automation with Ansible
- Secure secrets and TLS inside the cluster

The entire system is designed around network isolation, identity-based access, and controlled ingress.

---

## Key Features

- Private AKS Cluster (Only accessible inside the VNet)
- Azure Application Gateway for Containers as Gateway API ingress controller
- Self-hosted Azure DevOps runner inside the VNet
- Ansible-based configuration management
- Terraform-based infrastructure provisioning
- External Secrets Operator for Kubernetes secrets
- cert-manager for automated TLS certificate management
- OIDC & Azure Service Connections for secure pipeline authentication
- Jumphost VM for private cluster access and administrative operations

---
## Architecture Overview

### High-Level Flow

```
Developer
↓
Azure DevOps (OIDC / Service Connection)
↓
Terraform (Infrastructure Provisioning)
↓
Azure Infrastructure
  - Virtual Networks
  - Subnets (VM, AKS, Application Gateway, Postgres)
  - Private AKS Cluster
  - Azure Application Gateway for Containers
  - Azure PostgreSQL Flexible Server (Private)
  - Azure Key Vault
  - Private VM (Self-hosted Runner)
↓
Ansible Configuration
  - Configure Jumphost
  - Install and register Azure DevOps private runner
  - Kubernetes administrative configuration
↓
Helm Deployments to Private AKS
↓
Application Workloads (FastAPI + React)

```

## Runtime Traffic Flow

```

Client
↓
Public Endpoint (Application Gateway)
↓
Azure Application Gateway for Containers
↓
Kubernetes Gateway API
↓
Kubernetes Service
↓
Application Pods (FastAPI / React)
↓
Azure PostgreSQL Flexible Server

```

## CI/CD Execution Flow (Private Deployment Path)

```

Developer Commit
↓
Azure DevOps Pipeline Trigger
↓
Pipeline runs on Self-Hosted Private Runner (inside VNet)
↓
Docker Build & Push
↓
Helm Upgrade / Deploy to Private AKS
↓
AKS pulls secrets from Azure Key Vault (via External Secrets Operator)
↓
Application Updated in Cluster

```
---

## Security Model

### Network Isolation
- Private AKS cluster (no public API endpoint)
- Subnet segmentation
- Controlled ingress via Azure Application Gateway for Containers

### Identity & Access
- Managed Identities
- OIDC federation for Azure DevOps pipelines
- Azure Service Connections for controlled resource access
- RBAC enforced inside Kubernetes

### Secret Management
- Azure Key Vault integration
- External Secrets Operator
- No hardcoded secrets in repositories or pipelines

### CI/CD Security
- Self-hosted runner inside VNet
- No public build agents
- Infrastructure access controlled via scoped service connections

Detailed security documentation is available in `docs/security.md`.

---

## CI/CD Pipeline

The CI/CD pipeline is implemented using Azure DevOps and includes:

- Infrastructure provisioning via Terraform
- Application build and container image push
- Helm-based Kubernetes deployment
- Secure authentication using OIDC / Service Connections
- Execution on a private self-hosted runner inside the VNet

The runner VM is provisioned using Terraform and configured using Ansible.

---

## Repository Structure

```
.
├── ansible
├── azure_pipelines
│   ├── env
│   ├── templated-steps
│   └── templates
├── backend
│   └── fastapi
├── docs
├── frontend
│   └── react-recoil
├── helm
│   ├── app
│   └── azure-application-gateway-for-containers
├── terraform
│   ├── azure_modules
│   └── env
└── utils
```

---

## Directory Overview

- ansible/ – Configuration management and private runner setup  
- azure_pipelines/ – CI/CD definitions and reusable templates for Azure Devops pipelines
- helm/ – Kubernetes application deployments  
- terraform/ – Infrastructure as Code for Azure resources  
- backend/ – FastAPI backend  
- frontend/ – React frontend  
- docs/ – Detailed architectural, security, and system documentation  

---

## Getting Started (High-Level)

1. Provision infrastructure on Azure using the Terraform configs in /terraform.
2. Configure the private VM and Azure DevOps runner via Ansible configurations in /ansible.
3. Set up Azure DevOps service connections.
4. Execute pipeline to build and deploy workloads.
5. Access application through the Application Gateway endpoint.

---

## Limitations & Future Work

- Add monitoring stack (Prometheus / Grafana)
- Implement Horizontal Pod Autoscaler and Cluster Autoscaler
- Add policy enforcement (OPA)

---

## Additional Documentation

Detailed documentation is available in the `docs/` directory:

- docs/architecture.md – Full infrastructure and component breakdown  
- docs/security.md – Security model and threat considerations  
