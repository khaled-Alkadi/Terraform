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

# variable "admin_password" {
#   type        = string
#   description = "The password for the local administrator account on the VM."
#   sensitive = true # تمنع تيراموف من إظهار كلمة المرور في الـ Terminal أثناء التشغيل
# }
resource "azurerm_resource_group" "my-group" {
  name = "terraform-project"
  location = "westeurope"
  tags = {
    Envirenment = "Terraform"
    Owner = "terra"
  }
}

# resource "azurerm_management_lock" "rg_lock" {
#   name = "rg-delete-lock"
#   scope = azurerm_resource_group.my-group.id
#   lock_level = "CanNotDelete"
#   notes = "delete lock"
# }
resource "azurerm_virtual_network" "my-vnet" {
  name = "terra_vnet"
  location = azurerm_resource_group.my-group.location
  resource_group_name = azurerm_resource_group.my-group.name
  address_space  = [ "10.0.0.0/20" ]

  tags = azurerm_resource_group.my-group.tags
}
resource "azurerm_subnet" "frontend_subnet" {
  name = "frontend_subnet"
  resource_group_name = azurerm_resource_group.my-group.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes = [ "10.0.1.0/24" ]
}
resource "azurerm_subnet" "backend" {
  name = "Backend"
  resource_group_name = azurerm_resource_group.my-group.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes = [ "10.0.2.0/24" ]
}
resource "azurerm_subnet" "Database" {
  name = "Database"
  resource_group_name = azurerm_resource_group.my-group.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes = [ "10.0.3.0/24" ]
}

