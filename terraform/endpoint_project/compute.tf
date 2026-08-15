resource "azurerm_windows_virtual_machine" "win_serv" {
  name                  = "serv-win"
  resource_group_name   = azurerm_resource_group.pe_rg.name
  location              = azurerm_resource_group.pe_rg.location
  admin_password        = random_password.vm_secret.result
  admin_username        = "kha"
  network_interface_ids = [azurerm_network_interface.vm_nic.id, ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }
  size = "Standard_NV8as_v4"
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}