output "vault_id" {
  value = data.azurerm_key_vault.key_vault.id
}

output "vault_uri" {
  value = data.azurerm_key_vault.key_vault.vault_uri
}

output "db_password" {
  value = data.azurerm_key_vault_secret.key_vault_secrets["DBPASSWORD"].value
  sensitive = true
}

output "db_user" {
  value = data.azurerm_key_vault_secret.key_vault_secrets["DBUSER"].value
  sensitive = true
}