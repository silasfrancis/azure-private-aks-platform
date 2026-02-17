terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

resource "azurerm_federated_identity_credential" "alb_federation" {
  name                = "alb-federation"
  resource_group_name = var.resource_group_name
  parent_id           = var.alb_identity_id

  audience = ["api://AzureADTokenExchange"]
  issuer   = var.aks_oidc_issuer_url
  subject  = "system:serviceaccount:${var.alb_namespace}:alb-controller-sa"
}
