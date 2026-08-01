terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name       = "backend"
    key                  = "azure-rbac-lab.tfstate"
  }
}
provider "azurerm" {
  features {}
}
locals {
  res_location = "austriaeast"
  common_tags = {
    CreatedBy = "Terraform"
    ManagedBy = "IaC"
  }
}