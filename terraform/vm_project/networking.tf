resource "azurerm_virtual_network" "vm_vnet" {
  name                = "vnet-vm"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  address_space       = ["10.0.0.0/16"]
  tags                = local.common-tags
  depends_on = [ azurerm_resource_group.vm_rg ]
}
resource "azurerm_subnet" "vm_sub" {
  name                 = "sub_vnet"
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  resource_group_name  = azurerm_resource_group.vm_rg.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "nsg-vm"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  tags                = local.common-tags
}
resource "azurerm_network_security_rule" "allow_pub_access" {
  name                        = "Allow-Public-Access"
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
  resource_group_name         = azurerm_resource_group.vm_rg.name
  priority                    = 100
  access                      = "Allow"
  description                 = "Allow public access"
  destination_port_range      = "*"
  destination_address_prefix  = "*"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  direction                   = "Inbound"
}
resource "azurerm_subnet_network_security_group_association" "sub_asso" {
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
  subnet_id                 = azurerm_subnet.vm_sub.id
}
resource "azurerm_public_ip" "pub_ip" {
  name                = "pub-ip-vm"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}