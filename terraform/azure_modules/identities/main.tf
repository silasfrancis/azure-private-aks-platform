terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

resource "azurerm_user_assigned_identity" "vm_identity" {
  name = "${var.env}-vm-identity"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "k8_identity" {
  name = "${var.env}-k8-identity"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
}
