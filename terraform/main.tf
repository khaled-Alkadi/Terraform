# 1. إعلام تيراموف بالتعامل مع سحابة Azure واختيار إصدار المزود
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # أو الإصدار الأحدث المستقر المتوفر
    }
  }
    # كود رفع ملف الـ State وتأمينه في السحابة تلقائياً
  backend "azurerm" {
    resource_group_name  = "terraform-project"
    storage_account_name = "securetfstate2026" # الاسم الذي اخترته في الأعلى
    container_name       = "backend"
    key                  = "terraform.tfstate"
  }
}

# 2. تفعيل الاتصال واستخدام الميزات (مهم جداً لربط الحساب الحساب الفعلي)
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my-group" {
  name = "terraform-project"
  location = "westeurope"
  tags = {
    Envirenment = "Terraform"
    Owner = "terra"
  }
}

resource "azurerm_management_lock" "rg_lock" {
  name = "rg-delete-lock"
  scope = azurerm_resource_group.my-group.id
  lock_level = "CanNotDelete"
  notes = "delete lock"
}