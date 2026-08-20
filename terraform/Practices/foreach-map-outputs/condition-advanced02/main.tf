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
    key                  = "prac-foreach-con-advanced02.tfstate"
  }
}
provider "azurerm" {
  features {

  }
}
locals {
  res_prefix = "foreach-con-advanced02"
  st_prefix  = "foreachconadvanced02"
  location   = "northeurope"
}
resource "azurerm_resource_group" "prac_foreach_con_adv02_rg" {
  name     = "rg-${local.res_prefix}"
  location = local.location
}