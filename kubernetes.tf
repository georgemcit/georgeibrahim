/*
locals{ 
  cluster_names=["george01","george02","george03","george04","george05"]
}

resource "azurerm_kubernetes_cluster" "simplekubernetescluster1" {
  name                = "george1"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "exampleaks1"
default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_kubernetes_cluster" "simplekubernetescluster2" {
  name                = "george2"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "exampleaks2"
default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
resource "azurerm_kubernetes_cluster" "simplekubernetescluster3" {
  name                = "george3"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "exampleaks1"
default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
resource "azurerm_kubernetes_cluster" "simplekubernetescluster4" {
  name                = "george4"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "exampleaks1"
default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
resource "azurerm_kubernetes_cluster" "simplekubernetescluster5" {
  name                = "george5"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "exampleaks1"

default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
*/
locals{
   cluster_list=["montreal","toronto","vancouver","alberta"]
}
resource "azurerm_kubernetes_cluster" "georgeibrahimcluster" {
  name                = "georgeibrahimcluster"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "ccrf2301"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
resource "azurerm_kubernetes_cluster" "george" {
  for_each            = {for cluster in local.cluster_list: cluster=>cluster}
  name                = "${var.prefix}cluster"
  location            = azurerm_resource_group.georgeibrahim.location
  resource_group_name = azurerm_resource_group.georgeibrahim.name
  dns_prefix          = "ccrf2301"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
output "kube_name"{
  value=[for cluster in azurerm_kubernetes_cluster.george:cluster.name ]
}
variable "identity"{
 type=string
 default="SystemAssigned"
}
output "identity" {
  value = var.identity
}
variable "tags"{
 type=string
 default= "Production"
}
output "tags" {
  value = var.tags
}
resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
for_each               = azurerm_kubernetes_cluster.george
name                   = "${each.key}"
kubernetes_cluster_id  = each.value.id
vm_size                = "Standard_DS2_v2"
node_count             = 1 
  tags = {
    Environment = "Production"
  }
}
output "id" {
  value = [
    for cluster in azurerm_kubernetes_cluster.george: cluster.id
  ]
}
 
output "kube_config" {
  sensitive = true
  value = [ 
    for cluster in azurerm_kubernetes_cluster.george: cluster.kube_config_raw
  ]
}
 
output "client_key" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.george: cluster.kube_config.0.client_key
  ]
}
 
output "client_certificate" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.george: cluster.kube_config.0.client_certificate
  ]
}
 
output "cluster_ca_certificate" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.george: cluster.kube_config.0.cluster_ca_certificate
  ]
}
 
output "host" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.george: cluster.kube_config.0.host
  ]
}
variable "prefix"{
  type=string
  default="var.prefix"
}
