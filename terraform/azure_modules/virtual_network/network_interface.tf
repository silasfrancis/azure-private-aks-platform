resource "azurerm_network_interface" "vm_nic_private" {
  name = "VMNIC-private"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "vm_nic_public" {
  name = "VMNIC-public"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name = "exernal"
    subnet_id = azurerm_subnet.vm_subnet.id
    public_ip_address_id = azurerm_public_ip.jump_host_ip.id
    private_ip_address_allocation = "Dynamic"
    }
}