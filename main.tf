provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_postgresql_flexible_server" "example" {
  name                = "vt5
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  administrator_login          = "devops_dba"
  administrator_password       = "Larak2013"  // Hardcoded password
  version                      = "12"
  sku_name                     = "Standard_E32s_v3"
  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
}

resource "null_resource" "psql_hello_world" {
  depends_on = [azurerm_postgresql_flexible_server.example]

  provisioner "local-exec" {
    command = <<-EOF
      PGPASSWORD='Larak2013' psql -h ${azurerm_postgresql_flexible_server.example.fully_qualified_domain_name} -U devops_dba@${azurerm_postgresql_flexible_server.example.name} -d postgres -c "CREATE TABLE IF NOT EXISTS hello_world (message text); INSERT INTO hello_world VALUES ('Hello, World!');"
    EOF
    environment = {
      PGPASSWORD = "Larak2013"
    }
  }
}
