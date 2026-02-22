resource "azurerm_role_assignment" "vm_kv_access" {
  scope = var.key_vault_id
  role_definition_id = data.azurerm_role_definition.kv_jumphost_user_role.id
  principal_id = var.jump_host_vm_principal_id  
}

resource "azurerm_role_assignment" "vm_aks_access" {
  scope = var.aks_id
  role_definition_id = data.azurerm_role_definition.vm_jumphost_aks_role.id
  principal_id = var.jump_host_vm_principal_id  
}