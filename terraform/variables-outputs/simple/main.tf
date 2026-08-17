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
    key                  = "var-outputs.tfstate"
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "test_rg" {
  name     = var.resource_group
  location = var.location
  tags     = var.common_tags
}