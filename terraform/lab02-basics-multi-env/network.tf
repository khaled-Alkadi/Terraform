resource "azurerm_virtual_network" "muli_env_vnet" {
  name                = "multi-env-vnet"
  resource_group_name = azurerm_resource_group.multi_env_rg.name
  location            = azurerm_resource_group.multi_env_rg.location
  address_space       = ["192.168.0.0/16"]
  tags                = azurerm_resource_group.multi_env_rg.tags
}
resource "azurerm_subnet" "public_subnet" {
  name                 = "sub-public-web"
  resource_group_name  = azurerm_resource_group.multi_env_rg.name
  virtual_network_name = azurerm_virtual_network.muli_env_vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}
resource "azurerm_subnet" "private_subnet" {
  name                 = "sub-private-db"
  resource_group_name  = azurerm_resource_group.multi_env_rg.name
  virtual_network_name = azurerm_virtual_network.muli_env_vnet.name
  address_prefixes     = ["192.168.2.0/24"]
}