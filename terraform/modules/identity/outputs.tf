output "identity_id" {
  description = "Managed Identity resource ID"
  value       = azurerm_user_assigned_identity.identity.id
}

output "principal_id" {
  description = "Managed Identity principal (object) ID"
  value       = azurerm_user_assigned_identity.identity.principal_id
}
