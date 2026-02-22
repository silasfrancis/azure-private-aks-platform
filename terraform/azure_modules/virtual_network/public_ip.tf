resource "azurerm_public_ip" "jump_host_ip" {
  name                = "public${var.env}-jump-host-ip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"

  tags = {
    env = var.env
  }
}