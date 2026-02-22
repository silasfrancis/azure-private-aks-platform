terraform {
  backend "azurerm" {
    resource_group_name  = "dev"
    storage_account_name = "silasdevstorage"
    container_name       = "devtfstate"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
  features {}  
}

locals {
  environment = "dev"
  tag = "silasdev"
}

module "resource_group" {
  source = "../../azure_modules/resource_groups"

  resource_group_name = "dev"
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
  depends_on = [ module.resource_group ]
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

  env = local.environment
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  private_network_interface_id = [module.virtual_network.network_interface_id["private_interface"]]
  public_network_interface_ids = [module.virtual_network.network_interface_id["private_interface"]]
  vm_managed_identity = [module.managed_identites.managed_identities_id["vm_identity"]]
}

module "postgres_server" {
  source = "../../azure_modules/postgres_server"

  env = local.tag
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  db_name = local.tag
  db_username = module.key_vault.db_user
  db_password = module.key_vault.db_password
  db_subnet_id = module.virtual_network.subnet_ids["db_subnet"]
  private_dns_zone_id = module.virtual_network.private_dns_zone_id["pg"]
}

module "role_assignments" {
    source = "../../azure_modules/role_assignments"

    resource_group_id = module.resource_group.resource_group_id
    key_vault_id = module.key_vault.vault_id
    acr_id = module.acr.acr_id
    vnet_id = module.virtual_network.vnet_id
    aks_private_dns_zone_id = module.virtual_network.private_dns_zone_id["aks"]
    vm_principal_id = module.managed_identites.managed_identities_principal_id["vm_identity"]
    aks_principal_id = module.managed_identites.managed_identities_principal_id["aks_identity"]
    alb_principal_id = module.managed_identites.managed_identities_principal_id["alb_identity"]
}

resource "time_sleep" "wait_for_iam" {
  depends_on      = [module.role_assignments]
  create_duration = "60s"
}

module "aks" {
  source = "../../azure_modules/aks"

  env = local.tag
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  aks_subnet_id = module.virtual_network.subnet_ids["aks_subnet"]
  aks_managed_identity = [ module.managed_identites.managed_identities_id["aks_identity"] ]
  private_dns_zone_id = module.virtual_network.private_dns_zone_id["aks"]
  depends_on = [time_sleep.wait_for_iam]
}

module "authorization" {
  source = "../../azure_modules/authorization"

  resource_group_name = module.resource_group.resource_group_name
  alb_identity_id = module.managed_identites.managed_identities_id["alb_identity"]
  aks_oidc_issuer_url = module.aks.oidc_issuer_url
  alb_namespace = "azure-alb-system"
}

module "storage" {
  source = "../../azure_modules/storage"

  storage_account_name = "${local.tag}storage"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  env = local.environment
}