resource "azurerm_resource_group" "comp_rg" {
  name     = "${var.environments["compute"]}-rg"
  location = local.res_location
  tags     = local.common_tags
}
resource "azurerm_resource_group" "db_rg" {
  name     = "${var.environments["database"]}-rg"
  location = local.res_location
  tags     = local.common_tags
}
resource "azurerm_resource_group" "security_group" {
  name     = "sec-rg"
  location = local.res_location
  tags     = local.common_tags
}