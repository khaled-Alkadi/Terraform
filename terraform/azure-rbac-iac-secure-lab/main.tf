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
  db_env         = var.validate_environments["database"]
  com_env        = var.validate_environments["compute"]
  db_server_name = "${local.db_env}-postgresql-server"
  common_tags = {
    Project     = "azure-rbac-iac-secure-lab"
    ManagedBy   = "Terraform"
    Environment = local.db_env
  }
}