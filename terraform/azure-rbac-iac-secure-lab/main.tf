terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "stsharedtfstate01"
    container_name       = "backend"
    key                  = "azure-rbac-iac-secure-lab.tfstate"
  }
}
provider "azurerm" {
  features {}
}
locals {
  res_location = "westeurope"
  common_tags = {
    Project   = "abac-secure"
    CreatedBy = "Terraform"
    ManagedBy = "IaC"
  }
}