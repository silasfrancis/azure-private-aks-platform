terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}


resource "azurerm_storage_account" "tf_backend" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    delete_retention_policy {
      days = 30
    }
    restore_policy {
      days = 60
    }
    versioning_enabled = true 
  }

  tags = {
    env = var.env
  }
}

resource "azurerm_storage_container" "tf_state" {
  name = "${var.env}tfstate"
  storage_account_id = azurerm_storage_account.tf_backend.id
  container_access_type = "private"
}
