provider "azurerm" {                    
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "kubernetes" {
  host                   = module.aks.aks_host
  client_certificate     = module.aks.aks_client_certificate
  client_key             = module.aks.aks_client_key
  cluster_ca_certificate = module.aks.aks_cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = module.aks.aks_host
    client_certificate     = module.aks.aks_client_certificate
    client_key             = module.aks.aks_client_key
    cluster_ca_certificate = module.aks.aks_cluster_ca_certificate
  }
}


provider "kubectl" {
  host                   = module.aks.aks_host
  client_certificate     = module.aks.aks_client_certificate
  client_key             = module.aks.aks_client_key
  cluster_ca_certificate = module.aks.aks_cluster_ca_certificate
  load_config_file       = false
}