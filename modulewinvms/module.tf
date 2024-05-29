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
  virtual_network_name = azurerm_virtual_network.georgevn.name
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

resource "azurerm_windows_virtual_machine" "georgevm1" {
  name                = "george-machine1"
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
resource "azurerm_windows_virtual_machine" "georgevm2" {
  name                = "george-machine2"
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
locals{
  window_app=[for f in fileset("${path.module}/${var.dev}", "[^_]*.yaml") : yamldecode(file("${path.module}/${var.dev}/${f}"))]
  window_app_list = flatten([
    for app in local.window_app : [
      for windowapps in try(app.listofwindowsapp, []) :{
        name=windowapps.name
        os_type=windowapps.os_type
        sku_name=windowapps.sku_name

      }
    ]
])
}
resource "azurerm_service_plan" "george" {
  for_each            ={for sp in local.window_app_list: "${sp.name}"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location
    sku_name            = "P1v2"
    os_type             = "Windows"
}

resource "azurerm_windows_web_app" "george1980" {
  for_each            = azurerm_service_plan.george
  name                = each.value.name
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  location            = azurerm_resource_group.georgeibrahim.location
  service_plan_id     = each.value.id


  site_config {}
}
variable "dev"{
 type=string
 default="dev"
}
output "azure_window_app" {
  value = local.window_app_list
}
output "names_window_app" {
  value=[for app in local.window_app_list : app.name]
}
output "os_window_app" {
  value=[for app in local.window_app_list : app.os_type]
}
output "sku_window_app" {
  value=[for app in local.window_app_list : app.sku_name]
}
output "dev" {
  value = var.dev
}
