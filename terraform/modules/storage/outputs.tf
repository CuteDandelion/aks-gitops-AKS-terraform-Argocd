output "storage_account_name" {
  value       = azurerm_storage_account.tfstate.name
  description = "Name of the created storage account"
}

output "container_name" {
  value       = azurerm_storage_container.tfstate.name
  description = "Name of the created blob container"
}

output "storage_account_id" {
  value       = azurerm_storage_account.tfstate.id
  description = "ID of the created storage account"
}
