resource "azurerm_resource_group" "rgs" {
  for_each = var.rg_names
  name     = each.key
  location = "swedencentral"
}