resource "azurerm_virtual_network" "prac_foreach_con_adv_vnet" {
  name                = "vnet${local.res_prefix}"
  resource_group_name = azurerm_resource_group.prac_foreach_con_adv_rg.name
  location            = local.location
  address_space       = ["10.0.0.0/8"]
}
resource "azurerm_subnet" "subs" {
  resource_group_name  = azurerm_resource_group.prac_foreach_con_adv_rg.name
  virtual_network_name = azurerm_virtual_network.prac_foreach_con_adv_vnet.name
  for_each             = var.en_disable_all_creation ? { for key, val in var.sub_names : key => val if val.en_disable_creation } : {}
  name                 = "${each.key}-${local.res_prefix}"
  address_prefixes     = [each.value.address]
}