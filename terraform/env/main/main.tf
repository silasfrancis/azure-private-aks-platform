terraform {
  backend "azurerm" {
    resource_group_name  = "main"
    storage_account_name = "silasmainstorage"
    container_name       = "maintfstate"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  environment = "main"
  tag         = "silasmain"
}

module "resource_group" {
  source = "../../azure_modules/resource_groups"

  resource_group_name = "main"
}

module "managed_identites" {
  source = "../../azure_modules/managed_identites"

  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  env                     = local.tag
}

module "key_vault" {
  source = "../../azure_modules/key_vault"

  key_vault_name      = "silas-main-key-vault"
  resource_group_name = module.resource_group.resource_group_name
}

module "acr" {
  source = "../../azure_modules/acr"

  container_registry_name = "silasmain"
  resource_group_name     = module.resource_group.resource_group_name
  depends_on              = [module.resource_group]
}

module "virtual_network" {
  source = "../../azure_modules/virtual_network"

  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  env                     = local.environment
  virtual_network_name    = "${local.tag}-virtual-network"
}

module "virtual_machine" {
  source = "../../azure_modules/virtual_machine"

  env                          = local.environment
  resource_group_location      = module.resource_group.resource_group_location
  resource_group_name          = module.resource_group.resource_group_name
  private_network_interface_id = [module.virtual_network.network_interface_id["private_interface"]]
  public_network_interface_ids = [module.virtual_network.network_interface_id["public_interface"]]
  vm_managed_identity          = [module.managed_identites.managed_identities_id["vm_identity"]]
  jumphost_vm_managed_identity = [module.managed_identites.managed_identities_id["jump_host_vm_identity"]]
}

module "postgres_server" {
  source = "../../azure_modules/postgres_server"

  env                     = local.tag
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  db_name                 = local.tag
  db_username             = module.key_vault.db_user
  db_password             = module.key_vault.db_password
  db_subnet_id            = module.virtual_network.subnet_ids["db_subnet"]
  private_dns_zone_id     = module.virtual_network.private_dns_zone_id["pg"]
}

module "role_assignments" {
  source = "../../azure_modules/role_assignments"

  resource_group_id       = module.resource_group.resource_group_id
  key_vault_id            = module.key_vault.vault_id
  acr_id                  = module.acr.acr_id
  vnet_id                 = module.virtual_network.vnet_id
  aks_identity_id         = module.managed_identites.managed_identities_id["aks_identity"]
  aks_private_dns_zone_id = module.virtual_network.private_dns_zone_id["aks"]
  vm_principal_id         = module.managed_identites.managed_identities_principal_id["vm_identity"]
  aks_principal_id        = module.managed_identites.managed_identities_principal_id["aks_identity"]
  alb_principal_id        = module.managed_identites.managed_identities_principal_id["alb_identity"]
  depends_on              = [module.managed_identites]
}

resource "time_sleep" "wait_for_iam" {
  depends_on      = [module.role_assignments]
  create_duration = "60s"
}

module "aks" {
  source = "../../azure_modules/aks"

  env                          = local.tag
  resource_group_location      = module.resource_group.resource_group_location
  resource_group_name          = module.resource_group.resource_group_name
  aks_subnet_id                = module.virtual_network.subnet_ids["aks_subnet"]
  aks_managed_identity         = [module.managed_identites.managed_identities_id["aks_identity"]]
  private_dns_zone_id          = module.virtual_network.private_dns_zone_id["aks"]
  kubelet_identity_client_id   = module.managed_identites.kubelet_identities["kubelet_identity_client_id"]
  kubelet_identity_object_id   = module.managed_identites.kubelet_identities["kubelet_identity_object_id"]
  kubelet_identity_resource_id = module.managed_identites.kubelet_identities["kubelet_identity_resource_id"]
  depends_on                   = [time_sleep.wait_for_iam]
}

module "authorization" {
  source = "../../azure_modules/authorization"

  resource_group_name = module.resource_group.resource_group_name
  alb_identity_id     = module.managed_identites.managed_identities_id["alb_identity"]
  aks_oidc_issuer_url = module.aks.oidc_issuer_url
  alb_namespace       = "azure-alb-system"
}

module "role_assignments_jumphost" {
  source = "../../azure_modules/role_assignments_jump_host"

  aks_id                    = module.aks.cluster_id
  jump_host_vm_principal_id = module.managed_identites.managed_identities_principal_id["jump_host_vm_identity"]
  key_vault_id              = module.key_vault.vault_id
  resource_group_id         = module.resource_group.resource_group_id
}

module "storage" {
  source = "../../azure_modules/storage"

  storage_account_name    = "${local.tag}storage"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  env                     = local.environment
}