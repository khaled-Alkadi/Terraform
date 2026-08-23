resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  location = var.comm_location
  resource_group_name = var.rg_name
  address_space = [var.add_space]
}