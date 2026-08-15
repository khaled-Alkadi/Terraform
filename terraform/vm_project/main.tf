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
    key                  = "vm-test"
  }
}
provider "azurerm" {
  features {

  }
}
locals {
  common-tags = {
    CreatedBy = "Kha"
    ManagedBy = "IaC"
  }
}
resource "azurerm_resource_group" "vm_rg" {
  name     = "rg-vms"
  location = "northeurope"
  tags     = local.common-tags
}