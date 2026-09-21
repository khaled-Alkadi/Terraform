terraform {
  required_providers {
    azurerm ={
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "backup-rg"
    storage_account_name = "backupterra01st"
    container_name = "conbackup"
    key = "B2B-infrastructure"
  }
}
provider "azurerm" {
  features {
    
  }
}