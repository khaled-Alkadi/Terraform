resource "azurerm_private_dns_zone" "kv_dns" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.pe_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "kv_link" {
  name                  = "link-kv"
  resource_group_name   = azurerm_resource_group.pe_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.kv_dns.name
  virtual_network_id    = azurerm_virtual_network.pe_vnet.id
}
resource "azurerm_private_endpoint" "kv_pe" {
  name                = "pe-kv"
  resource_group_name = azurerm_resource_group.pe_rg.name
  location            = azurerm_resource_group.pe_rg.location
  subnet_id           = azurerm_subnet.pe_sub.id
  private_service_connection {
    name                           = "p-s-conn"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.allgemein_kv.id
    subresource_names              = ["Vault"]
  }
  private_dns_zone_group {
    name                 = "zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv_dns.id, ]
  }
}