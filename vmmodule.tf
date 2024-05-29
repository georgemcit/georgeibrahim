/*
module "module_win_vms" {
  source              = "./modulewinvms/"
  resource_group_name = "george_ibrahim"
  location                     = "West Europe"
  admin_username               = var.admin_username  
  admin_password               = var.admin_password 
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
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
variable "administrator_login"{
  type=string
}
output "administrator_login" {
  sensitive = true
  value = var.administrator_login
}
variable "administrator_login_password"{
  type=string
}
output "administrator_login_password" {
  sensitive = true
  value = var.administrator_login_password 
}
*/
