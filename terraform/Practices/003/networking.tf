resource "azurerm_virtual_network" "vnet_003" {
  name                = "vnet-003"
  resource_group_name = azurerm_resource_group.prac_003_rg.name
  location            = azurerm_resource_group.prac_003_rg.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "prac_003_subs" {
  count                = var.enable_subs ? length(var.sub_names) : 0
  name                 = "sub-${var.sub_names[count.index]}"
  resource_group_name  = azurerm_resource_group.prac_003_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_003.name
  address_prefixes     = [var.sub_prefixes[count.index]]
}