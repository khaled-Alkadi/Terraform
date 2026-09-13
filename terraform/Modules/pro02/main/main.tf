resource "azurerm_resource_group" "prod02_rg" {
  name     = "rg-prod02"
  location = "swedencentral"
}
resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  resource_group_name = azurerm_resource_group.prod02_rg.name
  location            = azurerm_resource_group.prod02_rg.location
  address_space       = ["10.0.0.0/16"]
}
module "sub_mod" {
  source = "../modules/subnet"
  sub_config = {
    sub_name  = "sub-dev-01"
    rg_name   = azurerm_resource_group.prod02_rg.name
    vnet_name = azurerm_virtual_network.vnet.name
    prefix    = "10.0.1.0/24"
  }
}
module "nic_mod" {
  source = "../modules/nic"
  nic_config = {
    nic_name         = "prod02-nic"
    rg_name          = azurerm_resource_group.prod02_rg.name
    loc              = azurerm_resource_group.prod02_rg.location
    target_subnet_id = module.sub_mod.sub_id_out
  }
}