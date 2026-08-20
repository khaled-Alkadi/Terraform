output "sub_outputs" {
  value = {for key, value in azurerm_subnet.multi_subs : key => value.address_prefixes[0]}
}