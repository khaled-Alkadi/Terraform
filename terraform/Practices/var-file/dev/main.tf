resource "azurerm_resource_group" "rgs" {
  name = var.rgs
  location = var.location
  tags = var.comm_tags
}
resource "azurerm_virtual_network" "vnets" {
  name = var.vnet_configs.name
  resource_group_name = azurerm_resource_group.rgs.name
  location = var.location
  address_space = var.vnet_configs.add_space
}
resource "azurerm_subnet" "subs" {
  name = var.sub_configs.name
  virtual_network_name = azurerm_virtual_network.vnets.name
  address_prefixes = var.sub_configs.prefix
  resource_group_name = azurerm_resource_group.rgs.name
}
resource "azurerm_storage_account" "sts" {
  name = var.st_configs.name
  location = var.location
  resource_group_name = azurerm_resource_group.rgs.name
  account_kind = var.st_configs.acc_kind
  account_tier = var.st_configs.acc_tier
  account_replication_type = var.st_configs.acc_repl
  access_tier = var.st_configs.access_tier
  tags = var.comm_tags
}