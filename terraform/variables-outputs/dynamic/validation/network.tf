resource "azurerm_virtual_network" "practice_vnet" {
  name = "vnet-${local.env_prefix}"
  resource_group_name = azurerm_resource_group.practice_rg.name
  location = azurerm_resource_group.practice_rg.location
  address_space = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "dynamic_subnets" {
  resource_group_name = azurerm_resource_group.practice_rg.name
  virtual_network_name = azurerm_virtual_network.practice_vnet.name
  for_each = var.dynamic_subnets
  name = "${each.key}-${local.env_prefix}"
  address_prefixes = [each.value.prefix]
}