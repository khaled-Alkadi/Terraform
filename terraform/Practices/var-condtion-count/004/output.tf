output "nsg_names_outputs" {
  value = azurerm_network_security_group.dynamic_nsg[*].name
}