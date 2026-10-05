resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_configs.name
  resource_group_name = var.vnet_configs.rg_name
  location = var.vnet_configs.location
  address_space = var.vnet_configs.add_space
}