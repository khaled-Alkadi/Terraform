resource "azurerm_virtual_network" "nic_vnet" {
  name                = "vnet-${local.res_prefix}"
  resource_group_name = azurerm_resource_group.prac_foreach_con_adv02_rg.name
  location            = local.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "nic_sub" {
  name                 = "sub-${local.res_prefix}"
  resource_group_name  = azurerm_resource_group.prac_foreach_con_adv02_rg.name
  virtual_network_name = azurerm_virtual_network.nic_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_public_ip" "pub_ips" {
  for_each = var.enable_nic_creation ? {for key, val in var.nic_names : key => val if val.enable_creation && val.enable_public_ip} : {}
  name = "pub-${each.key}"
  sku = "Standard"
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.prac_foreach_con_adv02_rg.name
  location = local.location
}
resource "azurerm_network_interface" "nics" {
  for_each            = var.enable_nic_creation ? { for key, val in var.nic_names : key => val if val.enable_creation} : {}
  name                = "${each.key}-${local.res_prefix}"
  resource_group_name = azurerm_resource_group.prac_foreach_con_adv02_rg.name
  location            = local.location
  ip_configuration {
    name                          = "Internal"
    public_ip_address_id          = each.value.enable_public_ip ? azurerm_public_ip.pub_ips[each.key].id : null
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.nic_sub.id
  }
}