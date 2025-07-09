resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  

  default_node_pool {
    name           = "agentpool"
    node_count     = var.node_count
    vm_size        = var.node_vm_size
    vnet_subnet_id = var.subnet_id
  }

identity {
  type         = "UserAssigned"
  identity_ids = [var.identity_id]
}

  network_profile {
    network_plugin = "azure"
  }

  linux_profile {
    admin_username = var.linux_admin_username
    ssh_key {
      key_data = file(var.ssh_key_path)
    }
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
