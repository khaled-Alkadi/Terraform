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
    key                  = "multi-env.tfstate"
  }
}
provider "azurerm" {
  features {}
}
locals {
  environment     = var.env
  resource_prefix = "env-project-${local.environment}"
}
resource "azurerm_resource_group" "multi_env_rg" {
  name     = "terra-multi-env-rg"
  location = "westeurope"
  tags = {
    env   = "muli_env"
    owner = "terra"
  }
}
