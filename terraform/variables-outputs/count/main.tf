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
    key                  = "practice-vars-outputs.tfstate"
  }
}
provider "azurerm" {
  features {

  }
}
resource "azurerm_resource_group" "rg_list" {
  count = length(var.service_names)
  name = "rg-${var.service_names[count.index]}"
  location = var.location
}