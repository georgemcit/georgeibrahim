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
