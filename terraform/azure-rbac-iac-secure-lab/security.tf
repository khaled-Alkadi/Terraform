# create a key vault #
######################
resource "azurerm_key_vault" "kv_rbac_lab" {
  name                = "kv-sec-rbac-lab"
  resource_group_name = azurerm_resource_group.security_group.name
  location            = local.res_location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.common_tags
  # tflint-ignore: terraform_deprecated_argument
  rbac_authorization_enabled = true
}
# create random_passwords #
###########################
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
# save created passwords in key vault-secrets #
###############################################
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
# user role for linux_vm #
##########################
resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.kv_rbac_lab.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_virtual_machine.rbac_vm.identity[0].principal_id
}
# roles for comp_team #
#######################
resource "azurerm_role_assignment" "vm_ops_rg_reader" {
  scope = azurerm_resource_group.comp_rg.id
  principal_id = data.azuread_group.vm_ops_team.object_id
  role_definition_name = "Reader"
}
resource "azurerm_role_assignment" "vm_ops_rg_sec_reader" {
  scope = azurerm_resource_group.security_group.id
  principal_id = data.azuread_group.vm_ops_team.object_id
  role_definition_name = "Reader"
}
resource "azurerm_role_assignment" "vm_ops_vm_contributor" {
  scope = azurerm_linux_virtual_machine.rbac_vm.id
  principal_id = data.azuread_group.vm_ops_team.object_id
  role_definition_name = "Virtual Machine Contributor"
}
resource "azurerm_role_assignment" "vm_ops_kv_secret_reader" {
  scope                = azurerm_key_vault.kv_rbac_lab.id # 👈 تعديل Scope إلى مستوى الـ Key Vault
  principal_id         = data.azuread_group.vm_ops_team.object_id
  role_definition_name = "Key Vault Reader"
}
resource "azurerm_role_assignment" "vm_ops_kv_secret_user" {
  scope = azurerm_key_vault_secret.sec_comp.resource_versionless_id
  principal_id = data.azuread_group.vm_ops_team.object_id
  role_definition_name = "Key Vault Secrets User"
}
# roles for db_team #
#####################
resource "azurerm_role_assignment" "db_ops_rg_reader" {
  scope = azurerm_resource_group.db_rg.id
  principal_id = data.azuread_group.db_ops_team.object_id
  role_definition_name = "Reader"
}
resource "azurerm_role_assignment" "db_ops_rg_sec_reader" {
  scope = azurerm_resource_group.security_group.id
  principal_id = data.azuread_group.db_ops_team.object_id
  role_definition_name = "Reader"
}
resource "azurerm_role_assignment" "db_ops_server_contributor" {
  scope = azurerm_postgresql_flexible_server.database_server.id
  principal_id = data.azuread_group.db_ops_team.object_id
  role_definition_name = "Contributor"
}
resource "azurerm_role_assignment" "db_ops_kv_reader" {
  scope = azurerm_key_vault.kv_rbac_lab.id
  principal_id = data.azuread_group.db_ops_team.object_id
  role_definition_name = "Key Vault Reader"
}
resource "azurerm_role_assignment" "db_ops_kv_secret_user" {
  scope                = azurerm_key_vault_secret.sec_db.resource_versionless_id
  principal_id         = data.azuread_group.db_ops_team.object_id
  role_definition_name = "Key Vault Secrets User"
}