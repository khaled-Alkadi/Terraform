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
    key                  = "db-mapping"
  }
}
provider "azurerm" {
  features {}
}
locals {
  # 1. دمج نصي معقد لتسمية قاعدة البيانات
  db_server_name = "sql-${var.environment}-dbserver"
  # 2. قرار منطقي: هل نعلّق النسخ الاحتياطي؟ (نعم في prod، لا في dev)
  enable_geo_backup = var.environment == "prod" ? true : false
  # 3. وسم موحد للقسم المسار
  common_tags = {
    Owner       = "IaC"
    environment = var.environment
  }
}
resource "azurerm_resource_group" "db_rg" {
  name     = "${local.db_server_name}-rg"
  location = "west europe"
  tags     = local.common_tags
}
resource "azurerm_storage_account" "storage_db" {
  name                     = "storagedb${var.environment}"
  resource_group_name      = azurerm_resource_group.db_rg.name
  location                 = azurerm_resource_group.db_rg.location
  account_replication_type = local.enable_geo_backup ? "GRS" : "LRS"
  account_tier             = "Standard"
  tags                     = local.common_tags
}
resource "azurerm_postgresql_flexible_server" "db" {
  name                   = local.db_server_name
  resource_group_name    = azurerm_resource_group.db_rg.name
  location               = azurerm_resource_group.db_rg.location
  version                = "13"
  administrator_login    = "kha"
  administrator_password = data.azurerm_key_vault_secret.db_administrator.value
  sku_name               = var.db_sku[var.environment]
  storage_mb             = var.db_storage_gb[var.environment] * 1024
  auto_grow_enabled      = var.environment == "prod" ? true : false
  backup_retention_days  = var.environment == "prod" ? 30 : 7
  tags                   = local.common_tags
}
