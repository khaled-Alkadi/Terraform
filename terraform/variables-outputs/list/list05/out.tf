output "subnet_names" {
  value = {for key, val in azurerm_subnet.subs: key => val.name}
}