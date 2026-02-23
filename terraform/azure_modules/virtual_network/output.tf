output "vnet_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "subnet_ids" {
  value = {
    vm_subnet = azurerm_subnet.vm_subnet.id
    aks_subnet = azurerm_subnet.aks_subnet.id
    db_subnet = azurerm_subnet.db_subnet.id
    alb_subnet = azurerm_subnet.alb_subnet.id
  }
}

output "network_interface_id" {
  value = {
    private_interface = azurerm_network_interface.vm_nic_private.id
    public_interface = azurerm_network_interface.vm_nic_public.id
  }
}

output "private_dns_zone_id" {
  value = {
    pg = azurerm_private_dns_zone.pg.id
    aks = azurerm_private_dns_zone.aks.id
  }
}

output "jump_host_public_ip" {
  value = azurerm_public_ip.jump_host_ip.ip_address
}