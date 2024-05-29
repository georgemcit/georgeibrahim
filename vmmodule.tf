module "module_win_vms" {
  source              = "./modulewinvms/"
  resource_group_name = "george_ibrahim"
  location            = "West Europe"
  admin_username      = var.administrator_login
  admin_password      = var.administrator_login_password
}
