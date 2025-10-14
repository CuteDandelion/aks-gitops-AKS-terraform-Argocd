data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "network" {
  source                  = "./modules/network"
  resource_group_name     = data.azurerm_resource_group.rg.name
  location                = data.azurerm_resource_group.rg.location
  vnet_name               = var.vnet_name
  vnet_address_space      = var.vnet_address_space
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  acr_name      = var.acr_name
  sku           = var.acr_sku
  admin_enabled = var.acr_admin_enabled
}

module "identity" {
  source              = "./modules/identity"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  identity_name = var.identity_name
}

module "acr_pull" {
  source       = "./modules/role_assignment"
  principal_id = module.identity.principal_id
  scope        = module.acr.acr_id
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  cluster_name        = var.cluster_name

  subnet_id   = module.network.subnet_id
  identity_id = module.identity.identity_id

  node_count           = var.node_count
  node_vm_size         = var.node_vm_size
  linux_admin_username = var.linux_admin_username
  ssh_public_key_data  = var.ssh_public_key_data

  acr_login_server = module.acr.acr_login_server
  acr_name         = module.acr.acr_name

  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip
}

provider "kubernetes" {
  host                   = module.aks.kube_config[0].host
  client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  depends_on = [helm_release.nginx_ingress]
}


# Disable Cloudflare due to no domain

#module "dns" {
#  source               = "./modules/dns"
#  cloudflare_api_token = var.cloudflare_api_token
#  cloudflare_zone_id   = var.cloudflare_zone_id

#  lb_ip_address = (
#    length(try(data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress, [])) > 0
#    ? data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].ip
#    : null
#  )
#}



module "tfstate" {
  source               = "./modules/storage"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
}

