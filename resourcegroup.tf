locals{
  rg_app=[for f in fileset("${path.module}/resource, "[^_]*.yaml") : yamldecode(file("${path.module}/resource/${f}"))]
  rg_app_list = flatten([
    for app in local.rg_app : [
      for rgapps in try(app.resourcegroup, []) :{
        name=george_ibrahim
        location: Canada Central 
      }
    ]
])
}
