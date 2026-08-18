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
locals {
  env_prefix = var.einvironments
  common-tages = {
    CreatedBy = "Kha"
    MAnagedBy = "IaC"
  }
}
resource "azurerm_resource_group" "practice_rg" {
  name     = "rg-practice-${local.env_prefix}"
  location = "northeurope"
  tags     = local.common-tages
}