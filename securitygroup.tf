/*
resource "azurerm_network_security_group" "web_nsg" {
  name                = var.azurerm_network_security_group_web_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = var.azurerm_network_security_group_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = var.azurerm_network_security_group_db_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
variable "azurerm_network_security_group_web_name"{
  type=string
}
variable "azurerm_network_security_group_app_name"{
  type=string
}
variable "azurerm_network_security_group_db_name"{
  type=string
}
*/
