provider "azurerm" {  
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "helm" {
  kubernetes { 
    host                   = module.aks.aks_host
    client_key             = module.aks.aks_client_key
    client_certificate     = module.aks.aks_client_certificate
    cluster_ca_certificate = module.aks.aks_cluster_ca_certificate
  }
}