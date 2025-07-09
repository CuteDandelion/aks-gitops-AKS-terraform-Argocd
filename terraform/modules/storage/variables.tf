variable "resource_group_name" {
  description = "Name of the Azure Resource Group for the storage account"
  type        = string
}

variable "location" {
  description = "Azure region where the storage account will be created"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container for storing Terraform state"
  type        = string
}
