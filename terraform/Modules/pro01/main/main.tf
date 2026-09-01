resource "azurerm_resource_group" "dev_rg" {
  name = "rg-dev"
  location = "swedencentral"
}
module "vnet" {
  source = "../modules/vnet"
  vnet_name = "vnet-dev"
  rg_name = azurerm_resource_group.dev_rg.name
  loc = azurerm_resource_group.dev_rg.location
}