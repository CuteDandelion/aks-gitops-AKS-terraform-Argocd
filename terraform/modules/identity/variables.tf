variable "resource_group_name" {
  description = "Resource Group for the managed identity"
  type        = string
}

variable "location" {
  description = "Azure region for the managed identity"
  type        = string
}

variable "identity_name" {
  description = "Name of the user-assigned managed identity"
  type        = string
}
