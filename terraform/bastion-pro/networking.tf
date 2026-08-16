resource "azurerm_virtual_network" "bast_vnet" {
  name                = "vnet-${local.env}"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  address_space       = ["192.168.0.0/16"]
  tags                = local.common_tags
}
resource "azurerm_subnet" "vms_sub" {
  name                 = "sub-vms-${local.env}"
  resource_group_name  = azurerm_resource_group.bastion_rg.name
  virtual_network_name = azurerm_virtual_network.bast_vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}
resource "azurerm_subnet" "bastion_sub" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.bastion_rg.name
  virtual_network_name = azurerm_virtual_network.bast_vnet.name
  address_prefixes     = ["192.168.2.0/26"]
}
resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-vm01"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  ip_configuration {
    name                          = "Public"
    subnet_id                     = azurerm_subnet.vms_sub.id
    private_ip_address_allocation = "Dynamic"
  }
}