resource "azurerm_postgresql_flexible_server" "database_server" {
  name                   = "db-server-rback-lab01"
  resource_group_name    = azurerm_resource_group.db_rg.name
  location               = local.res_location
  version                = "13"
  administrator_login    = "kha"
  administrator_password = azurerm_key_vault_secret.sec_db.value

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768

  tags = local.common_tags
}

# 2. إنشاء قاعدة البيانات
resource "azurerm_postgresql_flexible_server_database" "app_db" {
  name      = "${var.environments["database"]}-app"
  server_id = azurerm_postgresql_flexible_server.database_server.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
# 3. إضافة جدار الحماية للخدمات الداخلية
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_postgresql_flexible_server.database_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}