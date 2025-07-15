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

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "acr_sku" {
  description = "SKU for ACR (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "acr_admin_enabled" {
  description = "Whether to enable the ACR admin account"
  type        = bool
  default     = false
}

variable "identity_name" {
  description = "Name for the user-assigned managed identity"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "identity_id" {
  description = "User-assigned managed identity resource ID"
  type        = string
}

variable "acr_login_server" {
  description = "ACR login server URL (registry_profile.server)"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for the default node pool"
  type        = string
}

variable "linux_admin_username" {
  description = "Linux admin username for cluster nodes"
  type        = string
  default     = "azureuser"
}

variable "ssh_key_path" {
  description = "Path to the public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "dns_zone_name" {
  description = "DNS zone to create (e.g., kanban.example.com)"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account used for Terraform state"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container for Terraform state"
  type        = string
}

variable "service_cidr" {
  description = "Kubernetes service address range for AKS."
  type        = string
  default     = "10.240.0.0/16"
}

variable "dns_service_ip" {
  description = "DNS service IP for AKS."
  type        = string
  default     = "10.240.0.10"
}

variable "backend_key" {
  description = "The path (blob name) of the Terraform state file within the container."
  type        = string
  default     = "terraform.tfstate" # A sensible default
}