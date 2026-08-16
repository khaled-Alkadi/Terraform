resource "azurerm_network_security_group" "vms_nsg" {
  name                = "nsg-vms"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  tags                = local.common_tags
}
resource "azurerm_subnet_network_security_group_association" "nsg_asso" {
  network_security_group_id = azurerm_network_security_group.vms_nsg.id
  subnet_id                 = azurerm_subnet.vms_sub.id
}
resource "random_password" "vm_pass" {
  length  = 32
  upper   = true
  lower   = true
  special = true
}