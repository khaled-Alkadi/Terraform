resource "azurerm_virtual_network" "foreach_map_vnet" {
  name                = "vnet-${local.res_prefix}"
  location            = local.location
  resource_group_name = azurerm_resource_group.foreach_rg.name
  address_space       = [var.vnet_address]
}
resource "azurerm_subnet" "multi_subs" {
  resource_group_name  = azurerm_resource_group.foreach_rg.name
  virtual_network_name = azurerm_virtual_network.foreach_map_vnet.name
  for_each             = var.subs_names
  name                 = "sub-${each.key}-${local.res_prefix}"
  address_prefixes     = [each.value.cidr]
}