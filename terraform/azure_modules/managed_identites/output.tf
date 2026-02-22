output "managed_identities_principal_id" {
  value = {
    vm_identity = azurerm_user_assigned_identity.vm_identity.principal_id
    jump_host_vm_identity = azurerm_user_assigned_identity.jump_host_vm_identity.principal_id
    aks_identity = azurerm_user_assigned_identity.aks_identity.principal_id
    alb_identity = azurerm_user_assigned_identity.alb_identity.principal_id
  }
}

output "managed_identities_id" {
  value = {
    vm_identity = azurerm_user_assigned_identity.vm_identity.id
    jump_host_vm_identity = azurerm_user_assigned_identity.jump_host_vm_identity.id
    aks_identity = azurerm_user_assigned_identity.aks_identity.id
    alb_identity = azurerm_user_assigned_identity.alb_identity.id
  }
}

output "kubelet_identities" {
  value = {
    kubelet_identity_client_id = azurerm_user_assigned_identity.aks_identity.client_id
    kubelet_identity_object_id = azurerm_user_assigned_identity.aks_identity.principal_id
    kubelet_identity_resource_id = azurerm_user_assigned_identity.aks_identity.id
  }
}