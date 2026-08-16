resource "azurerm_public_ip" "bastion_ip" {
  name                = "pub-${local.env}-ip"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
}
resource "azurerm_bastion_host" "bastion_host" {
  name                = "host-${local.env}"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  ip_configuration {
    name                 = "Internal"
    subnet_id            = azurerm_subnet.bastion_sub.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}