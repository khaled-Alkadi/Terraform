terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name       = "backend"
    key                  = "list03.tfstate"
  }
}
provider "azurerm" {
  features {
    
  }
}