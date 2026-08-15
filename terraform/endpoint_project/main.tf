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
    key                  = "pe-project"
  }
}
provider "azurerm" {
  features {

  }
}
resource "azurerm_resource_group" "pe_rg" {
  name     = "rg-pe"
  location = "northeurope"
}