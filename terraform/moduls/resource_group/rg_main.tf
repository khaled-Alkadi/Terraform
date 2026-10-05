resource "azurerm_resource_group" "rg" {
  name = var.rg_configs.name
  location = var.rg_configs.location
}