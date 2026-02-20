resource "azurerm_role_assignment" "aks_kv_access" {
  scope              = var.key_vault_id
  role_definition_id = data.azurerm_role_definition.kv_user_role.id
  principal_id       = var.aks_principal_id
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope              = var.acr_id
  role_definition_id = data.azurerm_role_definition.k8_acr_pull_role.id
  principal_id       = var.aks_principal_id
}
