# resource "azurerm_role_assignment" "vm_kv_access" {
#   scope = var.key_vault_id
#   role_definition_id = data.azurerm_role_definition.kv_user_role.id
#   principal_id = var.vm_identity_id
# }

# resource "azurerm_role_assignment" "vm_acr_push" {
#   scope = var.acr_id
#   role_definition_id = data.azurerm_role_definition.vm_acr_push_role.id
#   principal_id = var.vm_identity_id
# }

# resource "azurerm_role_assignment" "vm_contributor" {
#   scope = var.resource_group_id
#   role_definition_id = data.azurerm_role_definition.vm_user_role.id
#   principal_id = var.vm_identity_id
# }

# resource "azurerm_role_assignment" "vm_aks" {
#   scope = var.aks_id
#   role_definition_id = data.azurerm_role_definition.vm_aks_role.id
#   principal_id = var.vm_identity_id
# }