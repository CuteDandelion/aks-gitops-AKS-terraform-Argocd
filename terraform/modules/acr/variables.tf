variable "resource_group_name" {
  description = "The RG where ACR will be created"
  type        = string
}

variable "location" {
  description = "Azure region for the ACR"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "SKU for ACR (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable the admin account (true/false)"
  type        = bool
  default     = false
}
