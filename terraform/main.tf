terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}


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
  ssh_key_path         = var.ssh_key_path

  acr_login_server = module.acr.acr_login_server
  acr_name         = module.acr.acr_name

  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip
}

module "dns" {
  source              = "./modules/dns"
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_zone_name       = var.dns_zone_name
}

module "tfstate" {
  source               = "./modules/storage"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
}
