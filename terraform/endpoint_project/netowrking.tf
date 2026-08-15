resource "azurerm_virtual_network" "pe_vnet" {
  name                = "vnet-pe"
  resource_group_name = azurerm_resource_group.pe_rg.name
  location            = azurerm_resource_group.pe_rg.location
  address_space       = ["192.168.0.0/16"]
}
resource "azurerm_subnet" "pe_sub" {
  name                 = "sub-pe"
  resource_group_name  = azurerm_resource_group.pe_rg.name
  virtual_network_name = azurerm_virtual_network.pe_vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}
resource "azurerm_subnet" "bastion_sub" {
  name = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.pe_rg.name
  virtual_network_name = azurerm_virtual_network.pe_vnet.name
  address_prefixes = ["192.168.2.0/26"]
  service_endpoints = ["Microsoft.Keyvault",]
}
resource "azurerm_public_ip" "Bastion_ip" {
  name = "pub-ip_bastion"
  sku = "Standard"
  resource_group_name = azurerm_resource_group.pe_rg.name
  location = azurerm_resource_group.pe_rg.location
  allocation_method = "Static"
}
resource "azurerm_bastion_host" "bastion" {
  name = "bastion-host"
  resource_group_name = azurerm_resource_group.pe_rg.name
  location = azurerm_resource_group.pe_rg.location
  ip_configuration {
    name = "configuration"
    subnet_id = azurerm_subnet.bastion_sub.id
    public_ip_address_id = azurerm_public_ip.Bastion_ip.id
  }
}
resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-vm"
  resource_group_name = azurerm_resource_group.pe_rg.name
  location            = azurerm_resource_group.pe_rg.location
  ip_configuration {
    name                          = "Internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.pe_sub.id
  }
}
