variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "subnet_id" {
  description = "Subnet resource ID for the node pool"
  type        = string
}

variable "identity_id" {
  description = "User-assigned managed identity resource ID"
  type        = string
}

variable "acr_name" {
  description = "ACR instance name (used for registry_profile.name)"
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

variable "service_cidr" {
  description = "The Kubernetes service address range."
  type        = string
  default     = "10.240.0.0/16"
}

variable "dns_service_ip" {
  description = "The IP address within the service CIDR to assign to the DNS service."
  type        = string
  default     = "10.240.0.10"
}

