resource "azurerm_storage_account" "adv_storages" {
  resource_group_name      = azurerm_resource_group.foreach_adv_rg.name
  location                 = local.location
  for_each                 = var.enable_st_creation ? { for k, v in var.st_names : k => v if v.en_st}: {}
  name                     = "${each.key}${local.st_prefix}"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
}
resource "azurerm_storage_container" "dy_con" {
  for_each = var.enable_st_creation ? {for k, v in var.st_names : k => v if v.en_st && v.cr_container}: {}
  name = "con${each.key}${local.st_prefix}"
  storage_account_name = azurerm_storage_account.adv_storages[each.key].name
}