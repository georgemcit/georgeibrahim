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

variable "admin_password" {
  description = "The admin password for the VMs"
  type        = string
}
variable "admin_username"{
  type=string
}
output "admin_username" {
  sensitive = true
  value = var.admin_username
}
variable "admin_password"{
  type=string
}
output "admin_password" {
  sensitive = true
  value = var.admin_password 
}
