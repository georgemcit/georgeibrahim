module "module_win_vms" {
  source              = "./modulethreetierapp/"
  resource_group_name = "george_ibrahim"
  location            = "West Europe"
  admin_username      = var.administrator_login
  admin_password      = var.administrator_login_password
  db_admin_username   = var.db_admin_username
  db_admin_password   = var.db_admin_password
}
