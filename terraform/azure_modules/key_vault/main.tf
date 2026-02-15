terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secrets" "key_vault_secrets_names" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


data "azurerm_key_vault_secret" "key_vault_secrets" {
  for_each     = toset(data.azurerm_key_vault_secrets.key_vault_secrets_names.names)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
