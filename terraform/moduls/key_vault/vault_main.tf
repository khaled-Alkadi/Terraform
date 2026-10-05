resource "azurerm_key_vault" "kv" {
  name = var.ky_configs.name
  resource_group_name = var.ky_configs.loc
  location = var.ky_configs.loc
  sku_name = var.ky_configs.sku
  tenant_id = var.ky_configs.ten_id
  rbac_authorization_enabled = var.ky_configs.rbac
  public_network_access_enabled = var.ky_configs.pub_access
  soft_delete_retention_days = var.ky_configs.soft_delete
}