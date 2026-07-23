data "azurerm_key_vault" "import_key_valut" {
  name                = "Mafatih"
  resource_group_name = "kalkad-allgemain"
}

data "azurerm_key_vault_secret" "db_administrator" {
  name         = "db-administrator"
  key_vault_id = data.azurerm_key_vault.import_key_valut.id
}