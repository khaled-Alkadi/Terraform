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
    resource_group_name  = "terraform-admin-rg"
    storage_account_name = "stsharedtfstate01" # الاسم الذي اخترته في الأعلى
    container_name       = "backend"
    key                  = "lab01-basics.tfstate"
  }
}
# 2. تفعيل الاتصال واستخدام الميزات (مهم جداً لربط الحساب الحساب الفعلي)
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "my-group" {
  name     = "terra-lab01-rg"
  location = "westeurope"
  tags = {
    Envirenment = "Terraform"
    Owner       = "terra"
  }
}

# resource "azurerm_management_lock" "rg_lock" {
#   name = "rg-delete-lock"
#   scope = azurerm_resource_group.my-group.id
#   lock_level = "CanNotDelete"
#   notes = "delete lock"
# }

resource "azurerm_windows_virtual_machine" "edu_win_ser" {
  name                  = "edu-win-server"
  location              = azurerm_resource_group.my-group.location
  resource_group_name   = azurerm_resource_group.my-group.name
  admin_username        = "kha"
  admin_password        = data.azurerm_key_vault_secret.secret_education_server.value
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = "Standard_B2s"
  tags                  = azurerm_resource_group.my-group.tags
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-smalldisk"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "data_disk" {
  name                 = "disk-edu-win-prod-01"
  create_option        = "Empty"
  location             = azurerm_resource_group.my-group.location
  resource_group_name  = azurerm_resource_group.my-group.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 50
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  caching            = "ReadWrite"
  lun                = 10
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.edu_win_ser.id

}