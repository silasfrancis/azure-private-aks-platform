terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

resource "azurerm_virtual_network" "virtual_network" {
  name = var.virtual_network_name
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}