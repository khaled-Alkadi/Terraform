data "azurerm_key_vault" "import_key_valut" {
  name = "Mafatih"
  resource_group_name = "kalkad-allgemain"
}

data "azurerm_key_vault_secret" "secret_education_server" {
  name = "sec-edu-server"
  key_vault_id = data.azurerm_key_vault.import_key_valut.id
}

output "secret_value_check" {
  value = data.azurerm_key_vault_secret.secret_education_server.value
  sensitive = true
}