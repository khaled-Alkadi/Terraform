resource "azurerm_network_security_group" "public_nsg" {
  name                = "nsg-public-web"
  resource_group_name = azurerm_resource_group.multi_env_rg.name
  location            = azurerm_resource_group.multi_env_rg.location
  tags                = azurerm_resource_group.multi_env_rg.tags
}
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "AllowSSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.multi_env_rg.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}
resource "azurerm_subnet_network_security_group_association" "public_assoc" {
  network_security_group_id = azurerm_network_security_group.public_nsg.id
  subnet_id                 = azurerm_subnet.public_subnet.id
}
resource "azurerm_network_security_group" "private_nsg" {
  name                = "nsg-private-db"
  resource_group_name = azurerm_resource_group.multi_env_rg.name
  location            = azurerm_resource_group.multi_env_rg.location
}
resource "azurerm_subnet_network_security_group_association" "private_assoc" {
  network_security_group_id = azurerm_network_security_group.private_nsg.id
  subnet_id                 = azurerm_subnet.private_subnet.id
}