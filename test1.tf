locals{
  vm_app=[for f in fileset("${path.module}/${var.vm}", "[^_]*.yaml") : yamldecode(file("${path.module}/${var.vm}/${f}"))]
  vm_app_list = flatten([
    for app in local.vm_app : [
      for vmapps in try(app.listofvmapp, []) :{
        name=vmapps.name
      }
    ]
])
}

resource "azurerm_resource_group" "george" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "ibrahim" {
  for_each            ={for sp in local.vm_app_list: "${sp.name}"=>sp }
  name                = each.value.name
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
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
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
variable "vm"{
 type=string
 default="vm"
}
output "vm" {
  value = var.vm
}
