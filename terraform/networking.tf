resource "azurerm_virtual_network" "my-vnet" {
  name = "terra_vnet"
  location = azurerm_resource_group.my-group.location
  resource_group_name = azurerm_resource_group.my-group.name
  address_space  = [ "10.0.0.0/20" ]

  tags = azurerm_resource_group.my-group.tags
}
resource "azurerm_subnet" "frontend_subnet" {
  name = "frontend_subnet"
  resource_group_name = azurerm_resource_group.my-group.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes = [ "10.0.1.0/24" ]
}
resource "azurerm_subnet" "backend" {
  name = "Backend"
  resource_group_name = azurerm_resource_group.my-group.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes = [ "10.0.2.0/24" ]
}
resource "azurerm_subnet" "Database" {
  name = "Database"
  resource_group_name = azurerm_resource_group.my-group.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes = [ "10.0.3.0/24" ]
}
