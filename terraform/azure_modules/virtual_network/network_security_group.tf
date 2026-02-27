resource "azurerm_network_security_group" "vm_security_group" {
  name = "${var.env}-vm-subnet-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags = {
    env = var.env
  }
}

resource "azurerm_network_security_group" "aks_security_group" {
  name = "${var.env}-aks-subnet-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags = {
    env = var.env
  }
}


resource "azurerm_network_security_group" "db_security_group" {
  name = "${var.env}-db-subnet-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags = {
    env = var.env
  }
}

resource "azurerm_network_security_group" "alb_security_group" {
  name                = "${var.env}-alb-subnet-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
    tags = {
    env = var.env
  }
}

