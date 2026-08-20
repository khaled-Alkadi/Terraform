output "st_names" {
  value = {for key, value in azurerm_storage_account.prac_foreach_st : key => value.name}
}