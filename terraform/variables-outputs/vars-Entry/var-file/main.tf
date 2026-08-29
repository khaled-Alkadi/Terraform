resource "azurerm_resource_group" "dev_rg" {
  name = var.name_rg
  location = "swedencentral"
}