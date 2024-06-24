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

  administrator_login          = "devops_dba"
  administrator_password       = var.db_admin_password  // Use a Terraform variable to set this securely
  version                      = "12"
  sku_name                     = "Standard_E32s_v3"  // Updated SKU
  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  // Other configurations as needed
}

variable "db_admin_password" {
  description = "The administrator password for PostgreSQL Flexible Server"
  type        = string
  sensitive   = true
}
