resource "azurerm_resource_group" "rg" {
  name     = "rg_dev"
  location = "swedencentral"
}
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-sub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "subs" {
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  for_each = zipmap(var.sub_names, var.sub_prefixes)
  name = each.key
  address_prefixes = [each.value]
}