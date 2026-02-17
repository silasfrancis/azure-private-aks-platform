terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
  
}

locals {
  environment = "development"
  tag = "silasDev"
}

module "resource_group" {
  source = "../../azure_modules/resource_groups"

  resource_group_name = local.environment
}

module "managed_identites" {
  source = "../../azure_modules/managed_identites"

  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  env = local.tag
}

module "key_vault" {
  source = "../../azure_modules/key_vault"

  key_vault_name = "silas-dev-key-vault"
  resource_group_name = module.resource_group.resource_group_name
}
module "acr" {
  source = "../../azure_modules/acr"

  container_registry_name = "silasdev"
  resource_group_name = module.resource_group.resource_group_name
}

module "virtual_network" {
  source = "../../azure_modules/virtual_network"

  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  env = local.environment
  virtual_network_name = "${local.tag}-virtual-network"
}

module "virtual_machine" {
  source = "../../azure_modules/virtual_machine"

  env = local.tag
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  network_interface_ids = [module.virtual_network.network_interface_id]
  vm_managed_identity = [module.managed_identites.managed_identities["vm_identity"]]
}

module "aks" {
  source = "../../azure_modules/aks"

  env = local.tag
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  aks_subnet_id = module.virtual_network.subnet_ids["aks_subnet"]
  aks_managed_identity = [ module.managed_identites.managed_identities["aks_identity"] ]
}

module "authorization" {
  source = "../../azure_modules/authorization"

  resource_group_name = module.resource_group.resource_group_name
  alb_identity_id = module.managed_identites.managed_identities["alb_identity"]
  aks_oidc_issuer_url = module.aks.oidc_issuer_url
  alb_namespace = "azure-alb-system"
}

module "postgres_server" {
  source = "../../azure_modules/postgress_server"

  env = local.tag
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  db_name = local.tag
  db_username = module.key_vault.db_user
  db_password = module.key_vault.db_password
  db_subnet_id = module.virtual_network.subnet_ids["db_subnet"]
  private_dns_zone_id = module.virtual_network.private_dns_zone_id
}

module "role_assignments" {
    source = "../../azure_modules/role_assignments"

    resource_group_id = module.resource_group.resource_group_id
    key_vault_id = module.key_vault.vault_id
    acr_id = module.acr.acr_id
    aks_id = module.aks.cluster_id
    vm_identity_id = module.managed_identites.managed_identities["vm_identity"]
    aks_identity_id = module.managed_identites.managed_identities["aks_identity"]
    alb_identity_id = module.managed_identites.managed_identities["alb_identity"]
}

module "storage" {
  source = "../../azure_modules/storage"

  storage_account_name = "${local.tag}-${local.environment}"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  env = local.environment
}