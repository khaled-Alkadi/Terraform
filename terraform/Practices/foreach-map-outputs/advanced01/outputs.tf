output "sub_addresses" {
  value = { for key, pre in azurerm_subnet.subs : key => pre.address_prefixes[0] }
}