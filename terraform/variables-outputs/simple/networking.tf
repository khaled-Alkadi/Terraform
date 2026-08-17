resource "azurerm_virtual_network" "test_vnet" {
  name                = var.virtual_network
  resource_group_name = azurerm_resource_group.test_rg.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  tags                = var.common_tags
}
resource "azurerm_subnet" "internal_subnet" {
  name                 = var.subnets_names["intern"]
  resource_group_name  = azurerm_resource_group.test_rg.name
  virtual_network_name = azurerm_virtual_network.test_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}