resource "azurerm_role_assignment" "alb_network_role_assignment" {
  scope              = var.resource_group_id
  role_definition_id = data.azurerm_role_definition.alb_network_role.id
  principal_id       = var.alb_identity_id
}
