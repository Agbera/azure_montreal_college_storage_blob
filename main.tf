#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
locals{ 
  cluster_names=["MontrealCollegeCluster","MontrealCollegeCluster2","MontrealCollegeCluster3","MontrealCollegeCluster4"]
}


resource "azurerm_resource_group" "montrealcollege" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "MontrealCollege" {
  name                = "montrealcollege-aks1"
  location            = azurerm_resource_group.montrealcollege.location
  resource_group_name = azurerm_resource_group.montrealcollege.name
  dns_prefix          = "montrealcollegeaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = "00000000-0000-0000-0000-000000000000"
    client_secret = "00000000000000000000000000000000"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.montrealcollege.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.montrealcollege.kube_config_raw
}
