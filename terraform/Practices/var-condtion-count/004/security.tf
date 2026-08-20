resource "azurerm_network_security_group" "dynamic_nsg" {
  count = var.enable_nsg_creation ? length(var.nsg_names): 0
  name = "nsg-${var.nsg_names[count.index]}"
  resource_group_name = azurerm_resource_group.prac_004_rg.name
  location = azurerm_resource_group.prac_004_rg.location
}