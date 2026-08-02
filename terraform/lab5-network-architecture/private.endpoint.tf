resource "azurerm_private_endpoint" "kv_pe" {
  name                = "pe-keyvault"
  resource_group_name = azurerm_resource_group.net_arch-rg.name
  location            = local.res_location
  subnet_id           = azurerm_subnet.endpoit_sub.id
  tags                = local.common_tags
  private_service_connection {
    name                           = "psc-keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.private_kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "kv-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv_dns.id]
  }
}