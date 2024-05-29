module "module_win_vms" {
  source              = "./modulewinvms/"
  resource_group_name = "george_ibrahim"
  location            = "West Europe"
  admin_username      = var.admin_username  
  admin_password      = var.admin_password 
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
