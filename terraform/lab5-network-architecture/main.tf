terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "backup1terra1tfstate"
    container_name       = "backend"
    key                  = "lab5.tfstate"
  }
}
provider "azurerm" {
  features {}
}
locals {
  res_location = "northeurope"
  common_tags = {
    CreatedBy = "Terraform"
    MangedBy  = "IaC"
    Project   = "Private-Endpoint-KV"
  }
}
resource "azurerm_resource_group" "net_arch-rg" {
  name     = "rg-net-arch"
  location = local.res_location
  tags     = local.common_tags
}