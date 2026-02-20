resource "azurerm_network_security_group" "vm_security_group" {
  name = "vm-subnet-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags = {
    env = var.env
  }
}

resource "azurerm_network_security_group" "aks_security_group" {
  name = "aks-subnet-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags = {
    env = var.env
  }
}


resource "azurerm_network_security_group" "db_security_group" {
  name = "db-subnet-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags = {
    env = var.env
  }
}