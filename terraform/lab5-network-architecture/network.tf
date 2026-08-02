resource "azurerm_virtual_network" "project_vnet" {
  name                = "vnet-project"
  resource_group_name = azurerm_resource_group.net_arch-rg.name
  location            = local.res_location
  tags                = local.common_tags
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "vms_sub" {
  name                 = "sub-vms"
  resource_group_name  = azurerm_resource_group.net_arch-rg.name
  virtual_network_name = azurerm_virtual_network.project_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "endpoit_sub" {
  name                 = "sub-endpoint"
  resource_group_name  = azurerm_resource_group.net_arch-rg.name
  virtual_network_name = azurerm_virtual_network.project_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}