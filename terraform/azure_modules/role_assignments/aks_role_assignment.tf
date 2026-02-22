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

resource "azurerm_role_assignment" "aks_dns_zone_access" {
  scope              = var.aks_private_dns_zone_id
  role_definition_id = data.azurerm_role_definition.aks_dns_zone_role.id
  principal_id       = var.aks_principal_id
}

resource "azurerm_role_assignment" "aks_vnet_network_role" {
  scope              = var.vnet_id
  role_definition_id = data.azurerm_role_definition.aks_vnet_role.id
  principal_id       = var.aks_principal_id
}

resource "azurerm_role_assignment" "aks_kublet_id_assign_role" {
  scope              = var.aks_identity_id
  role_definition_id = data.azurerm_role_definition.kublect_id_assign_role.id
  principal_id       = var.aks_principal_id
}
