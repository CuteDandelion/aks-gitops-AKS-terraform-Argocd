variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}


variable "resource_group_name" {
  description = "Name of the existing Azure Resource Group"
  type        = string
}
variable "location" {
  description = "Azure region where the Resource Group exists"
  type        = string
}

# Network Module Config                        

variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "subnet_name" {
  description = "The name of the Subnet within the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR blocks for the VNet"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "CIDR blocks for the Subnet"
  type        = list(string)
}
