resource "azurerm_windows_virtual_machine" "vm01" {
  name                = "vm-01"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  size                = "Standard_NV8as_v4"
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    version   = "latest"
    sku       = "2022-Datacenter"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  admin_password        = random_password.vm_pass.result
  admin_username        = "kha"
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
}