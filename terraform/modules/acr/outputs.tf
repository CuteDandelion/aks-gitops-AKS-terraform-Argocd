output "acr_login_server" {
  description = "The login server URL for the ACR"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "The fully qualified resource ID of the ACR"
  value       = azurerm_container_registry.acr.id
}
