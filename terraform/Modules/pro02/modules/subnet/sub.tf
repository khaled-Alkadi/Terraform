resource "azurerm_subnet" "test_sub" {
  resource_group_name = var.sub_config.rg_name
  name = var.sub_config.sub_name
  virtual_network_name = var.sub_config.vnet_name
  address_prefixes = [var.sub_config.prefix]
}