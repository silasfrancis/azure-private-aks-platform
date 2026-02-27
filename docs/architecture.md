# Architecture Documentation

## 1. Architectural Goals

This platform is designed to:

- Operate a fully private Kubernetes cluster on Azure
- Prevent public exposure of the Kubernetes API server
- Enforce network isolation and identity-based access
- Support secure CI/CD using a private self-hosted runner
- Separate infrastructure provisioning from application deployment
- Enable secure secret management using Azure-native services

---

## 2. High-Level Architecture

### High-Level Flow

```

Developer  
↓  
Azure DevOps (OIDC / Service Connection)  
↓  
Terraform (Infrastructure Provisioning)  
↓  
Azure Infrastructure  
  - Virtual Network (VNet)  
  - Subnets (AKS, Application Gateway, Management)  
  - Private AKS Cluster  
  - Azure Application Gateway for Containers  
  - Azure PostgreSQL Flexible Server (Private Endpoint)  
  - Azure Key Vault  
  - Private VM (Self-hosted Runner)  
↓  
Ansible Configuration  
↓  
Helm Deployments  
↓  
Application Workloads (FastAPI + React)

```
---

## 3. Network Architecture

### Virtual Network Layout

The Azure Virtual Network is segmented into dedicated subnets:

- **AKS Subnet**
  - Hosts private AKS worker nodes
  - No public inbound access
  - API server is private

- **Application Gateway Subnet**
  - Dedicated subnet for Azure Application Gateway for Containers
  - Only public ingress component

- **Management Subnet**
  - Jumphost VM
  - Azure DevOps self-hosted runner VM

- **Private Endpoint Integration**
  - Azure PostgreSQL Flexible Server
  - Azure Key Vault for DB secrets

All east-west traffic remains internal to the VNet.

---

## 4. Runtime Traffic Flow

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
Azure PostgreSQL Flexible Server (Private)

Key characteristics:

- TLS termination handled via cert-manager
- Gateway API manages routing rules
- No direct public exposure of pods
- Database accessible only via private networking

```
---

## 5. CI/CD Architecture

### Private Deployment Flow

```

Developer Commit  
↓  
Azure DevOps Pipeline Trigger  
↓  
Self-hosted Runner (inside VNet)  
↓  
Terraform Plan / Apply  
↓  
Docker Build & Push  
↓  
Helm Upgrade / Deploy to AKS  
↓  
Application Updated

### Design Decisions

- Pipelines do not run on Microsoft-hosted agents
- Runner resides inside the VNet
- Cluster credentials are never exposed publicly
- OIDC reduces secret-based authentication

```
---

## 6. Secret Management Architecture

- Azure Key Vault stores sensitive values
- External Secrets Operator syncs secrets into Kubernetes
- No secrets stored in Git
- No plaintext secrets in pipelines

---

## 7. Database Architecture

- Azure PostgreSQL Flexible Server
- Private networking only
- Accessible only from AKS subnet
- Used by FastAPI backend

The database is provisioned via Terraform and isolated from public internet access.

---

## 8. Infrastructure as Code

All infrastructure is provisioned using Terraform:

- Virtual Network and subnets
- AKS cluster
- Application Gateway for Containers
- Azure PostgreSQL
- Key Vault
- Virtual Machines
- Role assignments and identities

Remote state is stored in Azure Storage Account.

---

## 9. Scalability Considerations

- AKS supports horizontal pod autoscaling
- PostgreSQL can be vertically scaled
- Application Gateway scales independently
- Runner VM can be replicated if needed

---

## 10. Architectural Tradeoffs

- Increased operational complexity for improved security
- Private cluster limits ease of direct debugging
- Self-hosted runner introduces maintenance overhead
- Greater isolation improves production realism