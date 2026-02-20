output "vnet_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "subnet_ids" {
  value = {
    vm_subnet = azurerm_subnet.vm_subnet.id
    aks_subnet = azurerm_subnet.aks_subnet.id
    db_subnet = azurerm_subnet.db_subnet.id
  }
}

output "network_interface_id" {
  value = azurerm_network_interface.vm_nic.id
}

output "private_dns_zone_id" {
  value = {
    pg = azurerm_private_dns_zone.pg.id
    aks = azurerm_private_dns_zone.aks.id
  }
}