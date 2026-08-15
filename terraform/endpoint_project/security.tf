resource "azurerm_key_vault" "allgemein_kv" {
  name                          = "kv-allgemein"
  resource_group_name           = azurerm_resource_group.pe_rg.name
  location                      = azurerm_resource_group.pe_rg.location
  tenant_id                     = data.azurerm_client_config.corrent.tenant_id
  sku_name                      = "standard"
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = ["84.115.213.195/32"]
    virtual_network_subnet_ids = [azurerm_subnet.bastion_sub.id]
  }
}
resource "random_password" "project_secret" {
  length  = 32
  upper   = true
  lower   = true
  special = true
}
resource "azurerm_key_vault_secret" "project_secret" {
  name         = "sec-project"
  key_vault_id = azurerm_key_vault.allgemein_kv.id
  value        = random_password.project_secret.result
  depends_on   = [azurerm_private_endpoint.kv_pe]
}
resource "random_password" "vm_secret" {
  length  = 32
  upper   = true
  lower   = true
  special = true
}
resource "azurerm_key_vault_secret" "vm_secret" {
  name         = "sec-vm"
  key_vault_id = azurerm_key_vault.allgemein_kv.id
  value        = random_password.vm_secret.result
  depends_on   = [azurerm_private_endpoint.kv_pe]
}
resource "azurerm_role_assignment" "vm_role" {
  scope                = azurerm_key_vault_secret.vm_secret.versionless_id
  principal_id         = azurerm_windows_virtual_machine.win_serv.identity[0].principal_id
  role_definition_name = "Key Vault Secrets User"
}