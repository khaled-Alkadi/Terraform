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
    key                  = "bastion.tfstate"
  }
}
provider "azurerm" {
  features {}
}
locals {
  env = "bast"
  common_tags = {
    CreatedBy = "kha"
    ManagedBy = "IaC"
  }
}
resource "azurerm_resource_group" "bastion_rg" {
  name     = "${local.env}-rg"
  location = "northeurope"
  tags     = local.common_tags
}