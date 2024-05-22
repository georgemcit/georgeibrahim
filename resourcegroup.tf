locals{
  resource_group=[for f in fileset("${path.module}/resource", "[^_]*.yaml") : yamldecode(file("${path.module}/resource/${f}"))]
  resourcegroup_list = flatten([
    for app in local.resource_group: [
      for resourcegroup in try(app.listofresourcegroup, []) :{
        name=resourcegroup.name
      }
    ]
])
}
