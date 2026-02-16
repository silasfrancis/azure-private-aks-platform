output "managed_identities" {
  value = {
    vm_identity = azurerm_user_assigned_identity.vm_identity.id
    aks_identity = azurerm_user_assigned_identity.aks_identity.id
    alb_identity = azurerm_user_assigned_identity.alb_identity.id
  }
}