provider "azurerm" {
  features {}                

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
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
