resource "azurerm_network_interface" "comp_nic" {
  name                = "nic-${var.environments["compute"]}"
  resource_group_name = azurerm_resource_group.comp_rg.name
  location            = local.res_location
  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.comp_sub.id
  }
}
resource "azurerm_linux_virtual_machine" "rbac_vm" {
  name                            = "vm-${var.environments["compute"]}"
  resource_group_name             = azurerm_resource_group.comp_rg.name
  location                        = local.res_location
  network_interface_ids           = [azurerm_network_interface.comp_nic.id]
  size                            = "D2ads_v6"
  disable_password_authentication = false
  identity {type = "SystemAssigned"}
  tags = local.common_tags
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = 128
    storage_account_type = "Standard_LRS"
  }
  admin_username = "kha"
  admin_password = azurerm_key_vault_secret.sec_comp.value
}