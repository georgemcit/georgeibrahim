/*
resource "azurerm_resource_group" "georgeibrahim" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "georgevn" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
}

resource "azurerm_subnet" "georgesb" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.georgeibrahim.name
  virtual_network_name = azurerm_virtual_network.georgevn.name
  address_prefixes     = var.address_prefixes
}
*/
