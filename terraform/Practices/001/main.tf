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
    key                  = "prac001.tfstate"
  }
}
provider "azurerm" {
  features {

  }
}
resource "azurerm_resource_group" "create_RGs" {
  count = var.enable_creation ? length(var.env_names) : 0
  name = "rg-${var.env_names[count.index]}"
  location = "northeurope"
}