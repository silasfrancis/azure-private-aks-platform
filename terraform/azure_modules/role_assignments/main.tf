terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

data "azurerm_role_definition" "kv_user_role" {
  name = "Key Vault Secrets User"
}

data "azurerm_role_definition" "vm_user_role"{
    name = "Virtual Machine Contributor"
}

data "azurerm_role_definition" "vm_acr_push_role" {
  name = "AcrPush"
}

data "azurerm_role_definition" "vm_aks_role" {
  name = "Azure Kubernetes Service Cluster User Role"
}

data "azurerm_role_definition" "k8_acr_pull_role"{
    name = "AcrPull"
}

data "azurerm_role_definition" "alb_network_role" {
  name = "Network Contributor"
}

data "azurerm_role_definition" "alb_reader_role" {
  name = "Reader"
}

data "azurerm_role_definition" "aks_dns_zone_role"{
  name = "Private DNS Zone Contributor"
}

data "azurerm_role_definition" "aks_vnet_role"{
  name = "Network Contributor"
}

data "azurerm_role_definition" "kublect_id_assign_role"{
  name = "Managed Identity Operator"
}