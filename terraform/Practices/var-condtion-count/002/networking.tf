resource "azurerm_virtual_network" "vnet_names" {
  count = length(var.vnet_names)
  name = "vnet-${var.vnet_names[count.index]}"
  resource_group_name = azurerm_resource_group.networks_rg.name
  location = azurerm_resource_group.networks_rg.location
  address_space = [var.vnet_cidr_blocks[count.index]]
}