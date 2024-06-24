provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_postgresql_flexible_server" "example" {
  name                = "example-flexible-server"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  administrator_login    = "devops_dba"
  administrator_password = "Larak2013"
  version                = "12"
  sku_name               = "GP_Gen5_2"  # Example of a valid SKU name

  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  // Other configurations as needed
}
