resource "azurerm_storage_account" "prac_foreach_st" {
  resource_group_name = azurerm_resource_group.prac_foreach_rg.name
  location = local.location
  for_each = var.st_names
  name = "${each.key}${local.res_prefix}"
  account_replication_type = each.value.account_rep_type
  account_kind = each.value.account_kind
  account_tier = each.value.account_tier
  access_tier = each.value.access_tier
}