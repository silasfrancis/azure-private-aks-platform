output "managed_identities" {
  value = {
    vm_identity = azurerm_user_assigned_identity.vm_identity.id
    aks_identity = azurerm_user_assigned_identity.k8_identity.id
  }
}