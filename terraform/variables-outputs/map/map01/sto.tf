resource "azurerm_storage_account" "sts" {
    for_each = var.sts_config
  name = each.key
  account_replication_type = each.value.repl_type
  account_tier = each.value.acc_tier
  is_hns_enabled = each.value.hns
  account_kind = (each.value.acc_tier == "Premium" && each.value.hns ? "BlockBlobStorage" : "StorageV2")
  location = azurerm_resource_group.st_rg.location
  resource_group_name = azurerm_resource_group.st_rg.name
}