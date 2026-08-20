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
    key                  = "prac-foreach-con-advanced.tfstate"
  }
}
provider "azurerm" {
  features {

  }
}
locals {
  res_prefix = "foreach-con-advanced"
  st_prefix = "foreachconadvanced"
  location   = "northeurope"
}