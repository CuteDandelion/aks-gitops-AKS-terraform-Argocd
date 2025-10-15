provider "azurerm" { 
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


provider "helm" {
  kubernetes {
    host                   = try(module.aks.aks_host, null)
    client_certificate     = try(module.aks.aks_client_certificate, null)
    client_key             = try(module.aks.aks_client_key, null)
    cluster_ca_certificate = try(module.aks.aks_cluster_ca_certificate, null)
    config_path            = "/home/runner/.kube/config"
  }
}


provider "kubectl" {
  host                   = module.aks.aks_host
  client_certificate     = module.aks.aks_client_certificate
  client_key             = module.aks.aks_client_key
  cluster_ca_certificate = module.aks.aks_cluster_ca_certificate
  load_config_file       = false
}


