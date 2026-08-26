resource "azurerm_resource_group" "test_rg" {
  name     = "rg-test"
  location = "swedencentral"
}
resource "azurerm_virtual_network" "dev_vnet" {
  name                = "vnet-dev"
  resource_group_name = azurerm_resource_group.test_rg.name
  location            = azurerm_resource_group.test_rg.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "sub1" {
  name                 = var.sub_config.name
  virtual_network_name = azurerm_virtual_network.dev_vnet.name
  resource_group_name  = azurerm_resource_group.test_rg.name
  address_prefixes     = [var.sub_config.prefix]
  service_endpoints    = var.sub_config.service_endpoints
}