resource "azurerm_virtual_network" "rbac_vnet" {
  resource_group_name = azurerm_resource_group.security_group.name
  location            = local.res_location
  name                = "vnet-rbac"
  address_space       = ["10.0.0.0/16"]
  tags                = local.common_tags
}
resource "azurerm_subnet" "comp_sub" {
  name                 = "${var.environments["compute"]}-subnet"
  virtual_network_name = azurerm_virtual_network.rbac_vnet.name
  resource_group_name  = azurerm_resource_group.security_group.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "db_sub" {
  name                 = "${var.environments["database"]}-subnet"
  resource_group_name  = azurerm_resource_group.security_group.name
  virtual_network_name = azurerm_virtual_network.rbac_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}