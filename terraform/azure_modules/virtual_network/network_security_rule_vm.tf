resource "azurerm_network_security_rule" "vm-ngs-ingress" {
  name = "vm-ngs-ingress"
  priority = 100
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix      = "102.91.96.196"  #my public ip address
  destination_address_prefix = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm_security_group.name
}

resource "azurerm_network_security_rule" "vm-ngs-egress" {
  name = "vm-ngs-egress"
  priority = 200
  direction = "Outbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm_security_group.name
}

resource "azurerm_network_security_rule" "vm_deny_all_inbound" {
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
  network_security_group_name = azurerm_network_security_group.vm_security_group.name
}
