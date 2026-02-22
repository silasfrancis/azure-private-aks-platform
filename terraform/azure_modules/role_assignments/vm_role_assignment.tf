resource "azurerm_role_assignment" "vm_kv_access" {
  scope = var.key_vault_id
  role_definition_id = data.azurerm_role_definition.kv_user_role.id
  principal_id = var.vm_principal_id  
}
