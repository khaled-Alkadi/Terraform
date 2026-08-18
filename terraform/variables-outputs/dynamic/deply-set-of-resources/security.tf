resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-dynamic"
  resource_group_name = azurerm_resource_group.test_rg.name
  location            = azurerm_resource_group.test_rg.location
}
resource "azurerm_network_security_rule" "dynamic_rules" {
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.test_rg.name
  for_each                    = var.nsg_rules
  name                        = each.key
  access                      = "Allow"
  destination_port_range      = each.value.port
  destination_address_prefix  = "*"
  source_port_range           = "*"
  source_address_prefix       = "*"
  protocol                    = "Tcp"
  priority                    = each.value.priority
  direction                   = "Inbound"
}
resource "azurerm_subnet_network_security_group_association" "subs_assoc" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id = azurerm_subnet.dynamic_subnets["sub-public"].id # one Subnet.
}
# resource "azurerm_subnet_network_security_group_association" "subs_assoc" {
#   network_security_group_id = azurerm_network_security_group.nsg.id
#   for_each = azurerm_subnet.dynamic_subnets # All subnets.
#   subnet_id = each.value.id
# }