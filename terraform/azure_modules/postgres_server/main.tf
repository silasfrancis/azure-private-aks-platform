terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

resource "azurerm_postgresql_flexible_server" "pg_server" {
  name                = "${var.env}-pg-server"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  version             = "14"                    
  administrator_login = var.db_username      
  administrator_password = var.db_password
  delegated_subnet_id           = var.db_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = false

  sku_name = "B_Standard_B1ms"                    
  storage_mb = 32768                           

  tags = {
    env = var.env
  }
}


resource "azurerm_postgresql_flexible_server_database" "pg_db" {
  name = var.db_name
  server_id  = azurerm_postgresql_flexible_server.pg_server.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}
