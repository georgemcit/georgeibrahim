/*
locals{
   vm_list=["firstvm","secondvm","thirdvm","fourthvm","fifthvm"]
}

resource "azurerm_resource_group" "george" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "ibrahim" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.george.location
  resource_group_name = azurerm_resource_group.george.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.george.name
  virtual_network_name = azurerm_virtual_network.ibrahim.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "ibrahim" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.george.location
  resource_group_name = azurerm_resource_group.george.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "ibrahim" {
  for_each            = {for vm in local.vm_list: vm=>vm}
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.george.location
  resource_group_name   = azurerm_resource_group.george.name
  network_interface_ids = [azurerm_network_interface.ibrahim.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
variable "prefix" {
  default = "tfvmex"
}
variable "admin_username"{
  type=string
}
variable "admin_password"{
  type=string
}
variable "computer_name"{
  type=string
  default="georgeibrahim"
}
output "computer_name" {
  value = var.computer_name
}
output "admin_username" {
  sensitive = true
  value = var.admin_username
}
output "admin_password" {
  sensitive = true
  value = var.admin_password
}
*/
