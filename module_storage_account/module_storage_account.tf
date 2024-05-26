#module for storage account
resource "azurerm_resource_group" "georgerg" {
  name     = "george_ibrahim_1980_01_05"
  location = "eastus"
}
variable "storage_account_name" {
  description = "The name of the storage account"
}

variable "resource_group_name" {
  description = "The name of the storage account resource group"
}

variable "location" {
  description = "The Azure region where the storage account will be created"
  default     = "eastus"
}

variable "account_tier" {
  description = "The storage account tier (Standard or Premium)"
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The storage account replication type"
  default     = "LRS"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

}
output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}

