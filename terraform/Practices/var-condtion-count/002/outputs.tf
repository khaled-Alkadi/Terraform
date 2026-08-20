output "vnet_ips" {
  value = [azurerm_virtual_network.vnet_names[*].name,
   azurerm_virtual_network.vnet_names[*].address_space]
}