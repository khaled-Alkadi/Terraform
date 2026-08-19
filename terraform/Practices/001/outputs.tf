output "rgs_names" {
  value = azurerm_resource_group.create_RGs[*].name
}