terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name = "backend"
    key = "kv-access-policy.tfstate"
  }
}
provider "azurerm" {
  features {}
}