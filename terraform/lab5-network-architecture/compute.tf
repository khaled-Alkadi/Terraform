# 1. Network Interface للـ VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-test-vm"
  location            = local.res_location
  resource_group_name = azurerm_resource_group.net_arch-rg.name
  tags                = local.common_tags
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vms_sub.id
    private_ip_address_allocation = "Dynamic"
  }
}

# 2. Virtual Machine
resource "azurerm_linux_virtual_machine" "test_vm" {
  name                            = "vm-test-internal"
  resource_group_name             = azurerm_resource_group.net_arch-rg.name
  location                        = local.res_location
  size                            = "Standard_B2s" # حجم متوفر ومناسب للحسابات التجريبية
  admin_username                  = "kha"
  admin_password                  = "P@ssw0rd123456!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

# 3. منح الـ VM صلاحية القراءة من Key Vault
resource "azurerm_role_assignment" "vm_kv_user" {
  scope                = azurerm_key_vault_secret.vm_lin_secret.versionless_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_virtual_machine.test_vm.identity[0].principal_id
}