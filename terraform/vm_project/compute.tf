resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-vm"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.vm_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub_ip.id
  }
}
resource "azurerm_windows_virtual_machine" "win_server" {
  name                = "server-win"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  admin_username      = "kha"
  admin_password      = "wieN\\112211221987"
  size                = "Standard_NV8as_v4"
  tags                = local.common-tags
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  network_interface_ids = [azurerm_network_interface.vm_nic.id, ]
}