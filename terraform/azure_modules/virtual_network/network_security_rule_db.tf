resource "azurerm_network_security_rule" "db_allow_vm" {
  name                        = "AllowVMToDB"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"     
  source_address_prefix       = azurerm_subnet.vm_subnet.address_prefixes[0]
  destination_address_prefix  = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.db_security_group.name
}

resource "azurerm_network_security_rule" "db_allow_aks" {
  name                        = "AllowAKSToDB"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"   
  source_address_prefix       = azurerm_subnet.aks_subnet.address_prefixes[0]
  destination_address_prefix  = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.db_security_group.name
}

resource "azurerm_network_security_rule" "db_allow_outbound" {
  name                        = "AllowOutboundInternet"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.db_security_group.name
}

resource "azurerm_network_security_rule" "db_deny_all_inbound" {
  name                        = "DenyAllInbound"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.db_security_group.name
}
