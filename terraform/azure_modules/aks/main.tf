terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

resource "azurerm_kubernetes_cluster" "k8_cluster" {
  name                = "${var.env}-k8-cluster"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  kubernetes_version = 1.34
  dns_prefix_private_cluster = "silas${var.env}priv"
  private_dns_zone_id = var.private_dns_zone_id
  private_cluster_enabled = true
  oidc_issuer_enabled = true
  workload_identity_enabled = true

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2s_v3"
    vnet_subnet_id = var.aks_subnet_id
    auto_scaling_enabled = true
    node_count = 2
    max_count = 3
    min_count = 1
  }

network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }


  identity {
    type = "UserAssigned"
    identity_ids = var.aks_managed_identity
  }

  tags = {
    env = var.env
  }
}