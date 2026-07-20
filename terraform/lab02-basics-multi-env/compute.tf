resource "azurerm_public_ip" "vm_public_ip" {
  name                = "pip-linux-prod"
  resource_group_name = azurerm_resource_group.multi_env_rg.name
  location            = azurerm_resource_group.multi_env_rg.location
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "vm_nic" {
  name                = "linux-nic"
  resource_group_name = azurerm_resource_group.multi_env_rg.name
  location            = azurerm_resource_group.multi_env_rg.location
  tags                = azurerm_resource_group.multi_env_rg.tags
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = "linux-prod-vm"
  resource_group_name   = azurerm_resource_group.multi_env_rg.name
  location              = azurerm_resource_group.multi_env_rg.location
  admin_username        = "kha"
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = lookup(var.vm_size_mapping, local.environment, "Standard_B1s")
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"

  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_ssh_key {
    username   = "kha"
    public_key = file(var.ssh_public_key_path)
  }
}