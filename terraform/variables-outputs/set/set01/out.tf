output "rg_naes-out" {
  value = { for i, val in azurerm_resource_group.rgs : i => val.name }
}