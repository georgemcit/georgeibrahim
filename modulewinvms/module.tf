resource "azurerm_resource_group" "georgeibrahim" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "georgevn" {
  name                = "george-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
}

resource "azurerm_subnet" "georgesb" {
  name                 = "george_sb"
  resource_group_name  = azurerm_resource_group.georgeibrahim.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "georgenic" {
  name                = "george-nic"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.georgesb.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "georgevm" {
  name                = "george-machine"
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.georgenic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
