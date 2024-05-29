variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources"
  type        = string
}
variable "admin_username" {
  description = "The admin username for the VMs"
  type        = string
}
output "module_vm_private _ip" {
  description = "The private IP address of the web VM"
  value       = azurerm_win_virtual_machine.web_vm.private_ip_address
}
variable "admin_password" {
  description = "The admin password for the VMs"
  type        = string
}

