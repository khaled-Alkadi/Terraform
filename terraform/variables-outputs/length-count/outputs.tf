output "rg_names" {
  value = azurerm_resource_group.rg_list[*].name
  description = "Name of All RGs"
}