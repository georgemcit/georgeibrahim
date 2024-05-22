locals{
  my_sql_app=[for f in fileset("${path.module}/${var.sqlserver}", "[^_]*.yaml") : yamldecode(file("${path.module}/${var.sqlserver}/${f}"))]
  my_sql_app_list = flatten([
    for app in local.my_sql_app: [
      for serverapps in try(app.listofmysqlserver, []) :{
        name=serverapps.name
      }
    ]
])
}

resource "azurerm_mssql_server" "azuresqlserver" {
  for_each            ={for sp in local.my_sql_app_list: "${sp.name}"=>sp }
  name                = each.value.name
  version                      = var.version_number
  resource_group_name          = azurerm_resource_group.georgeibrahim.name
  location                     = azurerm_resource_group.georgeibrahim.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }

  tags = {
    environment = "production"
  }
}
variable "administrator_login"{
  type=string
}
variable "administrator_login_password"{
  type=string
}
variable "version_number"{
 type=string
 default="12.0"
}
variable "sqlserver"{
 type=string
 default="sqlserver"
}
/*

variable "environment_tag"{
 type=string
default="production"
}
variable "sql_server_name"{
 type=string
default="mssqlserver"
}
variable "minimum_tls_version"{
 type=string
 default="1.2"
}
*/
