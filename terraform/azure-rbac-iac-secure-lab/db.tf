resource "azurerm_postgresql_server" "database_server" {
  name                         = "${var.environments["database"]}-server"
  resource_group_name          = azurerm_resource_group.db_rg.name
  location                     = local.res_location
  sku_name                     = "B_Gen5_1"
  administrator_login          = "kha"
  administrator_login_password = azurerm_key_vault_secret.sec_db.value
  ssl_enforcement_enabled      = true
  version                      = "11"
}
resource "azurerm_postgresql_database" "app_db" {
  name                = "${var.environments["database"]}-app"
  resource_group_name = azurerm_resource_group.db_rg.name
  server_name         = azurerm_postgresql_server.database_server.name
  charset             = "UTF8"
  collation           = "en_US.utf8"
}
resource "azurerm_postgresql_firewall_rule" "allow_azure_services" {
  name                = "allow-azure-services"
  resource_group_name = azurerm_resource_group.db_rg.name
  server_name         = azurerm_postgresql_server.database_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}