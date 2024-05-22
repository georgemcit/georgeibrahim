locals{
  linux_app=[for f in fileset("${path.module}/${var.linuxappconfiguration}", "[^_]*.yaml") : yamldecode(file("${path.module}/${var.linuxappconfiguration}/${f}"))]
  linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(app.listoflinuxapp, []) :{
        name=linuxapps.name
        os_type=linuxapps.os_type
        sku_name=linuxapps.sku_name  
      }
    ]
])
}
resource "azurerm_service_plan" "george" {
  for_each            ={for sp in local.linux_app_list: "${sp.name}"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.george_ibrahim.name
  location            = azurerm_resource_group.george_ibrahim.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_linux_web_app" "george1980" {
  for_each            = azurerm_service_plan.george
  name                = each.value.name
  resource_group_name = azurerm_resource_group.george_ibrahim.name
  location            = azurerm_resource_group.george_ibrahim.location
  service_plan_id     = each.value.id
 site_config {}
}
