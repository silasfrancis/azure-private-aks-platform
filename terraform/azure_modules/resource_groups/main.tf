terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

data "azurerm_resource_group" "env"{
    name = var.resource_group_name
}