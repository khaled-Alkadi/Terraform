terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.5"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name       = "backend"
    key                  = "advance-03"
  }
}
provider "azurerm" {
  features {

  }
}
locals {
  res_prefix = "foreach-advanced03"
  st_prefix  = "foreachadvanced03"
  location   = "northeurope"
}
resource "azurerm_resource_group" "foreach_adv_rg" {
  name     = "rg-${local.res_prefix}"
  location = local.location
}
