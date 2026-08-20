terraform {
  required_providers {
    azurerm ={
        version = "~> 3.5"
        source = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name = "backend"
    key = "prac-004.tfstate"
  }
}
provider "azurerm" {
  features {
    
  }
}
resource "azurerm_resource_group" "prac_004_rg" {
  name = "rg-prac-004"
  location = "northeurope"
}
