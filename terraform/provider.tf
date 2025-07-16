provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "kubernetes" {
  host                   = module.aks.kube_config.host
  client_certificate     = module.aks.kube_config.client_certificate
  client_key             = module.aks.kube_config.client_key
  cluster_ca_certificate = module.aks.kube_config.cluster_ca_certificate
}

provider "helm" {
  debug = true 
  kubernetes { 
    host                   = module.aks.kube_config.host
    client_key             = module.aks.kube_config.client_key
    client_certificate     = module.aks.kube_config.client_certificate
    cluster_ca_certificate = module.aks.kube_config.cluster_ca_certificate
  }
}

provider "kubectl" {
  host                   = module.aks.kube_config.host
  client_certificate     = module.aks.kube_config.client_certificate
  client_key             = module.aks.kube_config.client_key
  cluster_ca_certificate = module.aks.kube_config.cluster_ca_certificate
  load_config_file       = false
}