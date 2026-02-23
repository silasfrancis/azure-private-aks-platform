resource "azurerm_subnet_network_security_group_association" "vm_subnet_association" {
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = azurerm_network_security_group.vm_security_group.id
}

resource "azurerm_subnet_network_security_group_association" "aks_subnet_association" {
  subnet_id                 = azurerm_subnet.aks_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_security_group.id
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_association" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_security_group.id
}

resource "azurerm_subnet_network_security_group_association" "alb_nsg_assoc" {
  subnet_id                 = azurerm_subnet.alb_subnet.id
  network_security_group_id = azurerm_network_security_group.alb_security_group.id
}