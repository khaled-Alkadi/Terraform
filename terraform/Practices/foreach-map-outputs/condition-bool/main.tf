terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name       = "backend"
    key                  = "prac-foreach-condition.tfstate"
  }
}
provider "azurerm" {
  features {

  }
}
locals {
  res_prefix = "foreach-condtion"
  st_prefix = "foreachcondtion"
  location   = "northeurope"
}
resource "azurerm_resource_group" "prac_foreach_rg" {
  name     = "rg-${local.res_prefix}"
  location = local.location
}