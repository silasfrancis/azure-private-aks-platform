resource "azurerm_network_interface" "vm_nic" {
  name = "VMNIC"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    }
}