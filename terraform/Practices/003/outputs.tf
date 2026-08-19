output "vnet_names" {
  value = azurerm_subnet.prac_003_subs[*].name
}