output "subnet_IDs" {
  value = azurerm_subnet.subnets[*].id
}