output "rg_names" {
  value = {for key, val in azurerm_resource_group.rgs: key => val.name}
}