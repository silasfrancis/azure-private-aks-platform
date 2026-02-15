data "azurerm_role_definition" "kv_user_role" {
  name = "Key Vault Secrets User"
}

data "azurerm_role_definition" "vm_user_role"{
    name = "Virtual Machine Contributor"
}

data "azurerm_role_definition" "vm_acr_push_role" {
  name = "AcrPush"
}

data "azurerm_role_definition" "k8_acr_pull_role"{
    name = "AcrPull"
}

