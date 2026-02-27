# Security Documentation

> **Note**: For architectural context, see [Architecture Documentation](architecture.md). For getting started, see the [main README](../README.md).


## 1. Security Objectives

This platform is designed with the following primary security goals:

- Eliminate public exposure of the Kubernetes control plane  
- Enforce strict network segmentation  
- Prefer identity-based authentication over static credentials  
- Prevent secret leakage in source control or CI/CD pipelines  
- Limit blast radius through scoped permissions  
- Protect application and database communication paths  

Security controls are implemented across network, identity, compute, and application layers.

---

## 2. Network Security Model

### Private Kubernetes Cluster

- AKS API server is private  
- No public Kubernetes endpoint  
- Cluster access restricted to resources within the Virtual Network (VNet)  

### Subnet Segmentation

The VNet is segmented into:

- Application Gateway subnet (public ingress)  
- AKS subnet (private compute)  
- Management subnet (jumphost and self-hosted runner)  

Only the Application Gateway exposes a public endpoint.

### Database Isolation

- Azure PostgreSQL Flexible Server uses private networking  
- No public database endpoint  
- Accessible only from the AKS subnet  

### East-West Traffic

All internal service-to-service communication remains within the VNet boundary.

---

## 3. Identity & Access Management

### Azure DevOps Authentication

- OIDC federation or Azure Service Connections  
- No long-lived cloud credentials stored in pipelines  
- Scoped RBAC permissions assigned to service principals  

### Managed Identities

- Used where possible for Azure resource access  
- Reduces credential management overhead  

### Kubernetes RBAC

- Role-Based Access Control enforced within the cluster  
- Namespaced workload isolation  
- Principle of least privilege applied to service accounts  

---

## 4. Secret Management

### Azure Key Vault

- Centralized storage for sensitive values  
- Secrets not stored in Git repositories  
- Secrets not embedded in Terraform or pipeline code  

### External Secrets Operator

- Synchronizes secrets from Key Vault into Kubernetes  
- Avoids hardcoded Kubernetes Secret manifests  
- Enables centralized secret rotation  

### Pipeline Secret Handling

- No plaintext secrets in CI/CD definitions  
- Secure variables stored in Azure DevOps  
- Identity-based authentication preferred over static secrets  

---

## 5. CI/CD Security

### Private Self-Hosted Runner

- Runs inside the VNet  
- No exposure of cluster credentials to public agents  
- Direct private access to AKS  

### Infrastructure Access Control

- Terraform state stored in a remote Azure Storage backend  
- Access to state restricted via RBAC  
- No local state files committed to the repository  

### Deployment Restrictions

- No direct `kubectl` access from public networks  
- Deployments executed only through controlled pipelines  

---

## 6. TLS & Ingress Security

- TLS certificates managed via cert-manager  
- HTTPS enforced at the Application Gateway  
- Gateway API manages routing rules  
- No direct pod exposure to the internet  

---

## 7. Threat Model Considerations

### Reduced Attack Surface

- No public Kubernetes API  
- No public database endpoint  
- Single public ingress point (Application Gateway)  

### Credential Exposure Mitigation

- OIDC instead of long-lived secrets  
- Managed identities instead of static keys  
- Key Vault integration for centralized secret control  

### Lateral Movement Mitigation

- Subnet segmentation  
- Scoped IAM roles  
- Kubernetes RBAC enforcement  

---

## 8. Security Posture Summary

This platform enforces:

- Network isolation by default  
- Identity-first authentication  
- Centralized secret management  
- Least-privilege access control  
- A single controlled ingress boundary  