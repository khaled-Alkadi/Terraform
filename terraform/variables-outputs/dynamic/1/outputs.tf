output "all_subnets_ids" {
  value       = { for k, v in azurerm_subnet.dynamic_subnets : k => v.id }
  description = "All Subnets IDs"
}