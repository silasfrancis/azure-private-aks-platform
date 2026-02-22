terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

data "azurerm_ssh_public_key" "ansible_ssh_key" {
  name                = "ansible-${var.env}"
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = "private-${var.env}-runner"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location
  network_interface_ids = var.network_interface_ids
  admin_username = "ansible_user"
  zone = "2"
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  size = "Standard_D2s_v3"
  admin_ssh_key {
    username = "ansible_user"
    public_key = data.azurerm_ssh_public_key.ansible_ssh_key.public_key
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  identity {
    type = "UserAssigned"
    identity_ids = var.vm_managed_identity
  }

}