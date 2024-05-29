/*
resource "azurerm_resource_group" "rg" {
  name     = var.azurerm_resource_group_name
  location = var.azurerm_resource_group_location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
variable "virtual_network_name"{
  type=string
}
variable  "address_space"{
  type =list
}
variable "azurerm_resource_group_name"{
  type=string
}
variable "azurerm_resource_group_location"{
  type=string
}
*/
