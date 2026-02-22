terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

data "azurerm_role_definition" "kv_jumphost_user_role" {
  name = "Key Vault Secrets User"
}

data "azurerm_role_definition" "vm_jumphost_aks_role" {
  name = "Azure Kubernetes Service Cluster User Role"
}