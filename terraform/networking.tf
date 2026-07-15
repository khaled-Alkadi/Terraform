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

resource "azurerm_network_security_group" "terra_nsg" {
  name = "nsg-edu-win-prod-01"
  resource_group_name = azurerm_resource_group.my-group.name
  location = azurerm_resource_group.my-group.location
  tags = azurerm_resource_group.my-group.tags
  security_rule {
    name = "Allow-RDP-Only-From-My-IP"
    priority = 100
    protocol = "Tcp"
    direction = "Inbound"
    access = "Allow"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "84.115.213.195/32"
    destination_address_prefix = "*"
  }
}
resource "azurerm_public_ip" "pub_ip" {
  name = "pub_ip_edu_server"
  resource_group_name = azurerm_resource_group.my-group.name
  location = azurerm_resource_group.my-group.location
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_network_interface" "vm_nic" {
  name = "nic-edu-win-prod-01"
  resource_group_name = azurerm_resource_group.my-group.name
  location = azurerm_resource_group.my-group.location
  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.frontend_subnet.id
    public_ip_address_id = azurerm_public_ip.pub_ip.id
  }
}
resource "azurerm_network_interface_security_group_association" "nic_nsg_associte" {
  network_interface_id = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.terra_nsg.id
  
}