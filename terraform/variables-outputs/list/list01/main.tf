resource "azurerm_resource_group" "dev_rg" {
  name = "rg-dev"
  location = "swedencentral"
}
resource "azurerm_virtual_network" "dev_vnet" {
  name = "vnet-dev"
  resource_group_name = azurerm_resource_group.dev_rg.name
  location = azurerm_resource_group.dev_rg.location
  address_space = ["10.0.0.0/16"]
  dns_servers = var.dns_server
}