resource "azurerm_key_vault" "kv_rbac_lab" {
  name                      = "kv-sec-rbac-lab"
  resource_group_name       = azurerm_resource_group.security_group.name
  location                  = local.res_location
  sku_name                  = "standard"
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  tags                      = local.common_tags
  enable_rbac_authorization = true
}
resource "random_password" "rand_comp_pass" {
  length  = 32
  upper   = true
  lower   = true
  special = true
}
resource "random_password" "rand_db_pass" {
  length  = 32
  upper   = true
  lower   = true
  special = true
}
resource "azurerm_key_vault_secret" "sec_comp" {
  name         = "${var.environments["compute"]}-admin-password"
  key_vault_id = azurerm_key_vault.kv_rbac_lab.id
  value        = random_password.rand_comp_pass.result
  tags         = local.common_tags
}

resource "azurerm_key_vault_secret" "sec_db" {
  name         = "${var.environments["database"]}-admin-password"
  key_vault_id = azurerm_key_vault.kv_rbac_lab.id
  value        = random_password.rand_db_pass.result
  tags         = local.common_tags
}
resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.kv_rbac_lab.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_virtual_machine.rbac_vm.identity[0].principal_id
}