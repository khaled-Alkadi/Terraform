resource "azurerm_subnet" "subnet" {
  name = var.sub_configs.name
  resource_group_name = var.sub_configs.rg_name
  virtual_network_name = var.sub_configs.vnet_name
  address_prefixes = var.sub_configs.prefix
}