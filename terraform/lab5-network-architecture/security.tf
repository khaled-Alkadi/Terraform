resource "azurerm_key_vault" "private_kv" {
  name                          = "kv-private-netarch-lab01"
  resource_group_name           = azurerm_resource_group.net_arch-rg.name
  location                      = local.res_location
  tags                          = local.common_tags
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = false
  rbac_authorization_enabled    = true
  sku_name                      = "standard"
}
resource "azurerm_key_vault_secret" "vm_lin_secret" {
  name         = "pass-db"
  key_vault_id = azurerm_key_vault.private_kv.id
  value        = var.db_password
  depends_on = [
    azurerm_private_endpoint.kv_pe
  ]
}
