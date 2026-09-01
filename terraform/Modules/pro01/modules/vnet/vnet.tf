resource "azurerm_virtual_network" "dev_vnet" {
  name = var.vnet_name
  location = var.loc
  resource_group_name = var.rg_name
  address_space = ["10.0.0.0/16"]
}