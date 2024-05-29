module "module_win_vms" {
  source              = "./modulewinvms/"
  resource_group_name = "george_ibrahim"
  location            = "West Europe"
  admin_username      = var.admin_username  
  admin_password      = var.admin_password 
}
