locals {
  cluster_names = ["MontrealCollegeCluster", "MontrealCollegeCluster2", "MontrealCollegeCluster3", "MontrealCollegeCluster4"]
}

resource "azurerm_resource_group" "montrealcollege" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "montrealcollege" {
  for_each = toset(local.cluster_names)

  name                = "${each.value}-aks"
  location            = azurerm_resource_group.montrealcollege.location
  resource_group_name = azurerm_resource_group.montrealcollege.name
  dns_prefix          = "${each.value}-aks-dns"

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

output "client_certificates" {
  value = { for cluster in azurerm_kubernetes_cluster.montrealcollege : cluster.name => cluster.kube_config.0.client_certificate }
}

output "kube_configs" {
  value = { for cluster in azurerm_kubernetes_cluster.montrealcollege : cluster.name => cluster.kube_config_raw }
}
