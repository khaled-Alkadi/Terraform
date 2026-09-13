resource "azurerm_network_interface" "prüd02_nic" {
  name = var.nic_config.nic_name
  resource_group_name = var.nic_config.rg_name
  location = var.nic_config.loc
  ip_configuration {
    name = "Internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.nic_config.target_subnet_id
  }
}